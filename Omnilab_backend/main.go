package main

import (
	"encoding/json"
	"fmt"
	"net/http"
)

type Experiment struct {
	ID          string      `json:"id"`
	Title       string      `json:"title"`
	Instruction string      `json:"instruction"`
	Equation    string      `json:"equation"`
	Components  []Component `json:"components"`
	StrictRules []Rule      `json:"strict_rules"`
}

type Component struct {
	ID    string `json:"id"`
	Label string `json:"label"`
	Color string `json:"color"`
	Role  string `json:"role"`
	Type  string `json:"type"`
}

type Rule struct {
	ActorID      string `json:"actor_id"`
	TargetID     string `json:"target_id"`
	NewColor     string `json:"new_color"`
	Feedback     string `json:"feedback"`
	ReactionType string `json:"reaction_type"`
}

func getLabConfig(id string) Experiment {
	switch id {
	case "1.1":
		return combinationReaction()
	case "1.2":
		return doubleDisplacement()
	case "1.3":
		return displacementReaction()
	default:
		return combinationReaction()
	}
}

//
// 🧪 Activity 1.1 — Combination Reaction
//
func combinationReaction() Experiment {
	return Experiment{
		ID:          "1.1",
		Title:       "Combination Reaction",
		Instruction: "Add water to quicklime.",
		Equation:    "CaO + H2O → Ca(OH)2 + Heat 🔥",

		Components: []Component{
			{ID: "water", Label: "Water", Color: "0xFF2196F3", Role: "ACTOR", Type: "DROPPER"},
			{ID: "quicklime", Label: "Quicklime (CaO)", Color: "0x33FFFFFF", Role: "TARGET", Type: "BEAKER"},
		},

		StrictRules: []Rule{
			{
				ActorID:      "water",
				TargetID:     "quicklime",
				NewColor:     "0xFFFFFFFF",
				Feedback:     "Calcium Hydroxide formed! Heat released 🔥",
				ReactionType: "HEAT",
			},
		},
	}
}

//
// 🧪 Activity 1.2 — Double Displacement
//
func doubleDisplacement() Experiment {
	return Experiment{
		ID:          "1.2",
		Title:       "Double Displacement",
		Instruction: "Add Potassium Iodide to Lead Nitrate.",
		Equation:    "Pb(NO3)2 + 2KI → PbI2 ↓ + 2KNO3",

		Components: []Component{
			{ID: "ki", Label: "KI", Color: "0xFFF1C40F", Role: "ACTOR", Type: "DROPPER"},
			{ID: "water", Label: "Water", Color: "0xFF2196F3", Role: "ACTOR", Type: "DROPPER"},
			{ID: "pb", Label: "Lead Nitrate", Color: "0x33FFFFFF", Role: "TARGET", Type: "BEAKER"},
		},

		StrictRules: []Rule{
			{
				ActorID:      "ki",
				TargetID:     "pb",
				NewColor:     "0xFFFFFF00",
				Feedback:     "Yellow precipitate formed!",
				ReactionType: "PRECIPITATE",
			},
			{
				ActorID:      "water",
				TargetID:     "pb",
				NewColor:     "0x33FFFFFF",
				Feedback:     "No reaction.",
				ReactionType: "NONE",
			},
		},
	}
}

//
// 🧪 Activity 1.3 — Displacement
//
func displacementReaction() Experiment {
	return Experiment{
		ID:          "1.3",
		Title:       "Displacement Reaction",
		Instruction: "Put Zinc into Copper Sulphate solution.",
		Equation:    "Zn + CuSO4 → ZnSO4 + Cu ↓",

		Components: []Component{
			{ID: "zn", Label: "Zinc Strip", Color: "0xFF888888", Role: "ACTOR", Type: "METAL"},
			{ID: "cuso4", Label: "CuSO4", Color: "0xFF3498DB", Role: "TARGET", Type: "BEAKER"},
		},

		StrictRules: []Rule{
			{
				ActorID:      "zn",
				TargetID:     "cuso4",
				NewColor:     "0xFFB87333",
				Feedback:     "Copper deposited!",
				ReactionType: "DISPLACEMENT",
			},
		},
	}
}

//
// 🌐 API HANDLER
//
func labHandler(w http.ResponseWriter, r *http.Request) {
	enableCORS(&w)

	id := r.URL.Query().Get("id")
	exp := getLabConfig(id)

	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(exp)
}

//
// 🔥 CORS FIX (IMPORTANT FOR FLUTTER DEVICE)
//
func enableCORS(w *http.ResponseWriter) {
	(*w).Header().Set("Access-Control-Allow-Origin", "*")
	(*w).Header().Set("Access-Control-Allow-Methods", "GET, POST, OPTIONS")
	(*w).Header().Set("Access-Control-Allow-Headers", "Content-Type")
}

//
// 🚀 MAIN
//
func main() {
	http.HandleFunc("/api/lab", labHandler)

	fmt.Println("🚀 Server running on http://0.0.0.0:8080")
	http.ListenAndServe("0.0.0.0:8080", nil)
}