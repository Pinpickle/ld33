package entities;

interface IActionable
{
    public function canAction(player:Player):Bool;
    public function executeAction(player:Player):Void;
}
