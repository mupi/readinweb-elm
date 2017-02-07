module State exposing (init, update, subscriptions)

import Types exposing (..)
import Navigation exposing (Location)
import User.State as User
import Login.State as Login
import Routing


init : Location -> ( Model, Cmd Msg )
init location =
    let
        currentRoute =
            Routing.parseLocation location
    in
        ( (Model User.init Login.init currentRoute), Cmd.none )


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

        OnLocationChange location ->
            let
                newRoute =
                    Routing.parseLocation location
            in
                ( { model | route = newRoute }, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
