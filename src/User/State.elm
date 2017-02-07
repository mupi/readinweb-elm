module User.State exposing (init, update)

import User.Types exposing (..)


init : Model
init =
    Model 0 "" "" "" ""


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            model ! []
