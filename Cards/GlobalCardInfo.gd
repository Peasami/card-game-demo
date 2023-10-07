# Holds data that is needed by the cards to be implemented.
class_name CARDINFO
var one = 1

enum targetTypes {
    AOEENEMY,
    AOEALLY,
    ENEMY,
    ALLY
}

var legalTargetData: Dictionary = {
    targetTypes.AOEENEMY: [ENUMS.slot_state.ENEMY, ENUMS.slot_state.EMPTY],
    targetTypes.AOEALLY: [ENUMS.slot_state.ALLY, ENUMS.slot_state.EMPTY],
    targetTypes.ENEMY: [ENUMS.slot_state.ENEMY],
    targetTypes.ALLY: [ENUMS.slot_state.ALLY]
}