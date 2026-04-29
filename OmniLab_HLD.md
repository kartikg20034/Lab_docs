# High-Level Design (HLD)
## Architectural Blueprint

### 1. Overview
A **Smart-Client Architecture** where Flutter handles simulation/logging, and the Spring Boot/Go backend acts as the Protocol Provider and AI Auditor.

### 2. Component Architecture
* **Flutter Frontend:** Widget Factory (UI Assembly), Local Session Buffer (Event Logs), Validation Engine (Local Logic).
* **Backend Hub:** Protocol Service (JSONB Configs), AI Auditor (Log analysis).
* **Data Layer:** Supabase (PostgreSQL for definitions/milestones).

### 3. The Log-driven Safety Flow
1. **Fetch:** App downloads config + success targets.
2. **Interact:** Student connects circuit; Local Buffer records the sequence.
3. **Trigger:** Mistake occurs; visual consequence shown.
4. **Audit:** Student asks for help; AI responds using formal persona.
