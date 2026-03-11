extends Node

# Global config handler

# World configs
var game_config: GameConfig

# Player configs
var player_config: PlayerConfig


func init(game_conf: GameConfig, player_conf: PlayerConfig):
	self.game_config = game_conf
	self.player_config = player_conf
