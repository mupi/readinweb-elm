port module State exposing (init, update, subscriptions)

import Type exposing (..)
import String


--My Modules

import User.State as User
import Register.State as Register
import Register.Type as Register
import Login.State as Login
import Login.Type as Login


init : ( Model, Cmd Msg )
init =
    let
        initModel =
            Model Register.init
                Login.init
                Login
                User.init
    in
        ( initModel
        , doLoadToken ()
        )


subscriptions : Model -> Sub Msg
subscriptions model =
    loadToken LoadToken


port saveToken : String -> Cmd msg


port doLoadToken : () -> Cmd msg


port loadToken : (Maybe String -> msg) -> Sub msg



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
                            , status = Index
                          }
                        , Cmd.none
                        )

                    _ ->
                        ( { model | register = updated }, Cmd.map RegisterMsg cmd )

        LoginMsg subMsg ->
            let
                ( updated, cmd ) =
                    Login.update subMsg model.login
            in
                case subMsg of
                    Login.LoginSuccess token response ->
                        let
                            newModel =
                                { model
                                    | user = updated.user
                                    , login = Login.init
                                    , status = Index
                                }
                        in
                            ( newModel, saveToken updated.user.token )

                    _ ->
                        ( { model | login = updated }, Cmd.map LoginMsg cmd )

        ChangeStatus status ->
            ( { model | status = status }, Cmd.none )

        LoadToken tokenMaybe ->
            case tokenMaybe of
                Nothing ->
                    ( model, Cmd.none )

                Just token ->
                    if String.isEmpty token then
                        ( model, Cmd.none )
                    else
                        let
                            ( loaded, cmd ) =
                                Login.update (Login.GetUser token) model.login
                        in
                            ( model, Cmd.map LoginMsg cmd )

        _ ->
            ( model, Cmd.none )
