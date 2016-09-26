module User.State exposing (init, update)

import User.Type exposing (..)


init : Model
init =
    Model 0 "" "" "" "" ""


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SetUsername username ->
            ( { model | username = username }, Cmd.none )

        SetName name ->
            ( { model | name = name }, Cmd.none )

        SetEmail email ->
            ( { model | email = email }, Cmd.none )

        SetPassword password ->
            ( { model | password = password }, Cmd.none )

        SetToken token ->
            ( { model | token = token }, Cmd.none )
