module State exposing (init, update)

import Type exposing (Model, Msg)
import Cadastro.State as Cadastro exposing (..)


init : ( Model, Cmd Msg )
init =
    ( Model Cadastro.init 0, Cmd.none )



--Update


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        _ ->
            ( model, Cmd.none )
