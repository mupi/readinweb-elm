module State exposing (init, update)

import Type exposing (..)


--My Modules

import User.State as User
import User.Type as User
import Register.State as Register
import Register.Type as Register


init : ( Model, Cmd Msg )
init =
    ( Model Register.init
        Register
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
                            , status = Login
                          }
                        , Cmd.map RegisterMsg cmd
                        )

                    _ ->
                        ( { model | register = updated }, Cmd.map RegisterMsg cmd )

        ChangeStatus status ->
            ( { model | status = status }, Cmd.none )

        _ ->
            ( model, Cmd.none )
