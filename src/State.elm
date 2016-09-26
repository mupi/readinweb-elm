module State exposing (init, update)

import Type exposing (..)


--My Modules

import User.State as User
import Register.State as Register
import Register.Type as Register
import Login.State as Login
import Login.Type as Login


init : ( Model, Cmd Msg )
init =
    ( Model Register.init
        Login.init
        Login
        User.init
    , Cmd.none
    )



--Update


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        RegisterMsg subMsg ->
            let
                ( updated, cmd ) =
                    Register.update subMsg model.register
            in
                case subMsg of
                    Register.RegisterSuccess token ->
                        ( { model
                            | user = updated.user
                            , register = Register.init
                          }
                        , Cmd.map RegisterMsg cmd
                        )

                    _ ->
                        ( { model | register = updated }, Cmd.map RegisterMsg cmd )

        LoginMsg subMsg ->
            let
                ( updated, cmd ) =
                    Login.update subMsg model.login
            in
                case subMsg of
                    Login.LoginSuccess token ->
                        ( { model
                            | user = updated.user
                            , login = Login.init
                          }
                        , Cmd.map LoginMsg cmd
                        )

                    _ ->
                        ( { model | login = updated }, Cmd.map LoginMsg cmd )

        ChangeStatus status ->
            ( { model | status = status }, Cmd.none )

        _ ->
            ( model, Cmd.none )
