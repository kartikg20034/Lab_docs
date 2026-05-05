# Non-Functional Requirements (NFR)
## System Quality & Technical Standards

### 1. Performance
* **NFR-1.1: Interaction Latency:** Local UI updates and validation checks must occur within <100ms.
* **NFR-1.2: Sync Latency:** Backend communication for log auditing and milestone saving must be <500ms.
* **NFR-1.3: Animation Quality:** Maintain a stable 60 FPS.

### 2. Reliability & Security
* **NFR-2.1: Internet Guard:** Simulation must pause/blur if connection is lost.
* **NFR-2.2: Data Integrity:** Milestone saves must be atomic.

### 3. Security
* **NFR-3.1: Authentication:** Secured via JWT through Supabase Auth.
* **NFR-3.2: Isolation:** Students only access their personal lab history.

### 4. Scalability
* **NFR-4.1: Schema-Agnostic Engine:** Adding an experiment requires zero code changes.
