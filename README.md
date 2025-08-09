# **1. Introduction**

This project implements a **Vending Machine Finite State Machine (FSM)** in Verilog.  
The machine accepts coins of different denominations (5k, 10k, 20k) and allows users to select from four items.  
It supports **dynamic pricing**, including price increase and discount features, and dispenses either one or two units of the selected item depending on stock and purchase quantity.  
The design also includes **automatic change return** when the inserted amount exceeds the adjusted price.

### **Main Features**
- Accepts 5k, 10k, and 20k coins.
- Four selectable items (**Item 1–Item 4**).
- **Price adjustment**: discount (`lowpriece`) or price increase (`uppriece1`, `uppriece2`).
- Dispenses one or two units (`SL=1` or `SL=2`).
- Returns change automatically.
- Returns to idle state after a transaction or reset signal.

---

# **2. Implementation**

The vending machine is implemented as a **Moore Finite State Machine (FSM)** with the following states:

1. **S0 (Idle)** – Waits for coin insertion.  
2. **S5 / S10 / S20** – Represents the amount of money currently inserted (5k, 10k, or 20k).  
3. **IT1 – IT4** – Item selection states (one per item).  
4. **SL1 / SL2** – Dispensing states for one or two units.  

## **2.1 State Transitions**
- From **S0**, inserting a coin moves the machine to the corresponding money state.  
- From a money state (**S5/S10/S20**), selecting an item triggers a price check:  
  - If the inserted amount ≥ adjusted price → move to the corresponding `ITx` state.  
  - If not enough money → remain in the same money state until more coins are inserted.  
- In `ITx`, the quantity (`SL`) determines whether the machine moves to `SL1` or `SL2`.  
- After dispensing, the machine returns to **S0**.  

---

## **2.2 Price Adjustment Logic**

AdjustedPrice = BasePrice

If (lowpriece == item_code):
AdjustedPrice -= 5k // Apply discount

If (uppriece1 == item_code):
AdjustedPrice += 5k // First price increase

If (uppriece2 == item_code):
AdjustedPrice += 5k // Second price increase
**Explanation:**  
- `lowpriece` applies a 5k discount to the matching item.  
- `uppriece1` and `uppriece2` are independent price increase controls.  
- They can target different items or both target the same item.  
- If both target the same item, the total increase is **+10k**.  

---

## **2.3 Operation Details**

- The machine accepts coins of **5k**, **10k**, and **20k**, represented by inputs `cen5`, `cen10`, and `cen20`.  
- The user can purchase **one of four items** (`item1`, `item2`, `item3`, `item4`) with a maximum quantity of **two** per transaction (`SL = 2'b01` for one unit, `SL = 2'b10` for two units).  
- **Base prices:**  
  - Item1 = 5k  
  - Item2 = 5k  
  - Item3 = 10k  
  - Item4 = 10k  
- `SLit1`–`SLit4` store the current stock of each item.  
- The machine automatically returns change (`drop5`, `drop10`, `drop20`) if the inserted amount exceeds the adjusted price.  
  - Example: Insert 20k, buy one Item4 (price 10k) → change returned = 10k → `drop10 = 1`.  
- Dispensing outputs (`dropitem1`–`dropitem4`) indicate how many units of an item are released.  
  - Example: Buy 2 units of Item1 → `dropitem1 = 2`.  
- **Price control signals:**  
  - `uppriece1` applies a +5k increase to Item1 and/or Item2 (based on its value).  
  - `uppriece2` applies a +5k increase to Item3 and/or Item4 (based on its value).  
  - `lowpriece` applies a -5k discount to Item3 and/or Item4 (based on its value).  
- After completing a purchase, `SLit1`–`SLit4` are updated to reflect the remaining stock.

---

# **3. Simulation Results**

### **Simulation Result – PIC1**  
Inserted **10k** (`cen10=1`), selected **Item 2** (`item2=1`) with quantity **2** (`SL=2'b10`).  
Current stock of Item 2 is **10** (`SLit2=1010`).  
`lowpriece=10` applies a discount to **Item 4**, so the price of Item 2 remains **5k**.  
Payment is processed, and **2 units** of Item 2 are dispensed (`dropitem2=10`).  
Stock of Item 2 decreases to **8** (`SLit2=1000`).  

![Simulation PIC1](test/pic1.jfif)

---

### **Simulation Result – PIC2**  
Inserted **20k** (`cen20=1`), selected **Item 4** (`item4=1`) with quantity **1** (`SL=2'b01`).  
Current stock of Item 4 is **10** (`SLit4=1010`).  
`lowpriece=10` applies a discount to **Item 4**, so the price is reduced to **5k**.  
Payment is processed, and **1 unit** of Item 4 is dispensed (`dropitem4=01`).  
Stock of Item 4 decreases to **9** (`SLit4=1001`).  
Returned **15k** as change (`drop5=1`, `drop10=1`).  

![Simulation PIC2](test/pic2.jfif)

---

### **Simulation Result – PIC3**  
Inserted **20k** (`cen20=1`), selected **Item 1** (`item1=1`) with quantity **1** (`SL=2'b01`).  
Current stock of Item 1 is **10** (`SLit1=1010`).  
`uppriece1=01` applies a price increase to **Item 1**, so the price becomes **10k**.  
Payment is processed, and **1 unit** of Item 1 is dispensed (`dropitem1=01`).  
Stock of Item 1 decreases to **9** (`SLit1=1001`).  
Returned **10k** as change (`drop10=1`).  

![Simulation PIC3](test/pic3.jfif)