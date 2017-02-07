module User.Rest exposing (..)

import Http
import Json.Decode as Decode exposing (field)
import User.Types exposing (Model)


usersDecoder : Decode.Decoder (List Model)
usersDecoder =
    Decode.list userDecoder


userDecoder : Decode.Decoder Model
userDecoder =
    Decode.map5 Model
        (field "id" Decode.int)
        (field "username" Decode.string)
        (field "name" Decode.string)
        (field "email" Decode.string)
        (field "url" Decode.string)
