module Register.State exposing (init, update)

import Task exposing (Task)
import HttpBuilder
import Json.Decode as Decode exposing (..)
import Json.Encode as Encode exposing (..)
import Array exposing (..)


-- My Modules

import Register.Type exposing (..)
import User.Type as User
import User.State as User


init : Model
init =
    Model "" User.init


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SetUsername username ->
            let
                ( newUser, cmd ) =
                    User.update (User.SetUsername username) model.user
            in
                ( { model | user = newUser }, Cmd.none )

        SetName name ->
            let
                ( newUser, cmd ) =
                    User.update (User.SetName name) model.user
            in
                ( { model | user = newUser }, Cmd.none )

        SetEmail email ->
            let
                ( newUser, cmd ) =
                    User.update (User.SetEmail email) model.user
            in
                ( { model | user = newUser }, Cmd.none )

        SetPassword password ->
            let
                ( newUser, cmd ) =
                    User.update (User.SetPassword password) model.user
            in
                ( { model | user = newUser }, Cmd.none )

        ClickRegisterUser ->
            ( model, registerUserCmd model registerUrl )

        RegisterSuccess sucesso ->
            let
                ( newUser, cmd ) =
                    User.update (User.SetToken sucesso.data) model.user
            in
                ( { model | user = newUser }, Cmd.none )

        RegisterError error ->
            ( { model | error = toString error }, Cmd.none )
