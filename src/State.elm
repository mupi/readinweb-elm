module State exposing (init, update, subscriptions)

import Type exposing (..)


--My Modules

import User.State as User
import Login.State as Login


init : ( Model, Cmd Msg )
init =
    ( (Model User.init Login.init), Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UserMsg subMsg ->
            let
                ( updatedUser, cmd ) =
                    User.update subMsg model.user
            in
                ( { model | user = updatedUser }, Cmd.map UserMsg cmd )

        LoginMsg subMsg ->
            let
                ( updatedLogin, cmd ) =
                    Login.update subMsg model.login
            in
                ( { model | login = updatedLogin }, Cmd.map LoginMsg cmd )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
