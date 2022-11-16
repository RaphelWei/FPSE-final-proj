module G = Game


type message_object = {message: string} [@@deriving yojson]

type game_object = {game: G.game} [@@deriving yojson]

val serialize_message : message_object -> string

val serialize_game : game_object -> string

val deserialize_message : string -> message_object

val deserialize_game : string -> game_object

val lookup_session: string -> string

val game_create: string -> string

val game_join: string -> string -> string

val game_start: string -> string

val game_move: string -> string -> string

val game_quit: string -> string

val game_end: string -> string

val game_delete: string -> string

val game_list: unit -> string

val game_info: string -> string

val game_save: string -> string

val game_load: string -> string

val game_reset: string -> string

val game_undo: string -> string

val clients: unit -> (int, Dream.websocket) Hashtbl.t

val sessions: unit -> (int, Dream.session) Hashtbl.t

val games: unit -> (string, G.game) Hashtbl.t

val game_id: unit -> int

val session_id: unit -> string option






