# Functional Requirements Document (FR)
## System Capabilities & Content Catalog

### 1. Simulation & Interaction Engine
* **FR-1.1: Protocol-Driven UI Assembly:** The app must dynamically generate lab interfaces based on JSONB configurations.
* **FR-1.2: Success Validation Logic:** Flutter must validate the current state against "Success Targets" provided in the lab config.
* **FR-1.3: Physics Graphing:** Real-time generation of graphs for Class 9 Motion labs.

### 2. Content Catalog
* **Chemistry (Class 10):** pH Testing, Reactivity Series, Saponification, Equation Balancer.
* **Physics (Class 10):** Ohm's Law Verification, Series/Parallel Circuits.
* **Chemistry (Class 9):** Bohr’s Atomic Shell Builder, Law of Conservation of Mass.
* **Physics (Class 9):** F=ma Trolley Sim, Inertia Coin-flick, Momentum Conservation.

### 3. Agentic & Safety Layer
* **FR-3.1: Proactive Safety Interceptor:** Detect "Dangerous Actions" (e.g., short circuits).
* **FR-3.2: Mistake Permission:** Students proceed with dangerous actions to see sensory results; event is logged.
* **FR-3.3: Formal AI Guidance:** Contextual tutoring using local log buffers.

### 4. Sensory & Data
* **FR-4.1: Sensory Mapping:** Audio (hiss, pop, splash) and Haptics (vibration) mapped to events.
* **FR-4.2: Milestone CRUD:** Cloud-save snapshots to Supabase upon completion.
