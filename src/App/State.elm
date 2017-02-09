module App.State exposing (init, update, subscriptions)

import Navigation exposing (Location)
import App.Routing exposing (parseLocation, Route(..))
import App.Types exposing (..)
import Login.State as Login
import Question.State as Question
import Question.Types as Question
import User.State as User
import Material


init : Location -> ( Model, Cmd Msg )
init location =
    let
        currentRoute =
            parseLocation Nothing location

        mdl =
            Material.model
    in
        ( (Model
            Login.init
            Question.init
            currentRoute
            (Global Nothing Nothing)
            mdl
          )
        , Cmd.none
        )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UserMsg subMsg ->
            let
                global =
                    model.global

                ( user, cmd ) =
                    case global.user of
                        Nothing ->
                            ( Nothing, Cmd.none )

                        Just user ->
                            let
                                ( updatedUser, cmd ) =
                                    User.update subMsg user
                            in
                                ( Just updatedUser, cmd )

                newGlobal =
                    { global | user = user }
            in
                ( { model | global = newGlobal }, Cmd.map UserMsg cmd )

        LoginMsg subMsg ->
            let
                ( updatedLogin, cmd ) =
                    Login.update subMsg model.login

                newGlobal =
                    if updatedLogin.user == Nothing then
                        Global Nothing Nothing
                    else
                        Global updatedLogin.user updatedLogin.token

                newCmd =
                    if updatedLogin.user == Nothing then
                        Cmd.map LoginMsg cmd
                    else
                        Navigation.newUrl "#index"
            in
                ( { model | login = updatedLogin, global = newGlobal }, newCmd )

        QuestionMsg subMsg ->
            let
                ( updatedQuestion, cmd ) =
                    Question.update subMsg model.question model.global
            in
                ( { model | question = updatedQuestion }, Cmd.map QuestionMsg cmd )

        OnLocationChange location ->
            let
                newRoute =
                    parseLocation model.global.user location

                ( newModel, cmd ) =
                    case newRoute of
                        QuestionRoute questionId ->
                            let
                                ( updatedQuestion, cmd ) =
                                    Question.update (Question.GetQuestion questionId) model.question model.global
                            in
                                ( { model | question = updatedQuestion }, Cmd.map QuestionMsg cmd )

                        QuestionPageRoute page ->
                            let
                                ( updatedQuestion, cmd ) =
                                    Question.update (Question.GetQuestionPage page) model.question model.global
                            in
                                ( { model | question = updatedQuestion }, Cmd.map QuestionMsg cmd )

                        _ ->
                            ( model, Cmd.none )
            in
                ( { newModel | route = newRoute }, cmd )

        ShowIndex ->
            ( model, Navigation.newUrl "#index" )

        ShowLogin ->
            ( model, Navigation.newUrl "#login" )

        ShowUser ->
            ( model, Navigation.newUrl "#users" )

        Mdl msg_ ->
            Material.update Mdl msg_ model


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
