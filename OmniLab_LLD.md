# Low-Level Design (LLD)
## Implementation & Logic Detail

### 1. The Protocol Contract (JSONB)
Experiments are defined by a JSON including metadata, canvas_config, components, validation_logic (Target State), and safety_rules (Logic Maps).

### 2. Frontend Hierarchy (Flutter)
* **WidgetFactory:** A static utility returning widgets based on JSON type (BEAKER, RESISTOR).
* **LabLogger:** A singleton session buffer capturing action types, values, and snapshots.
* **SafetyService:** A stateless evaluator that runs Logic Maps (e.g., property: velocity, op: GT, threshold: 10).

### 3. State & Interaction
* **Instant Feedback:** UI updates immediately during drag.
* **Snap-back Logic:** If an action is "illegal" (UI-wise), the component slides back to origin via TweenAnimation.
* **Science Consequences:** Logged only for valid UI actions leading to poor science outcomes (e.g., Overload).

### 4. Lifecycle & Persistence
* **Reset on Close:**initState() fetches JSON; dispose() clears logs. Only successful milestones are pushed to Supabase.
