module View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Type exposing (..)
import Login.View as Login
import User.View as User
import Routing exposing (Route(..))


view : Model -> Html Msg
view model =
    div []
        [ page model
        ]


page : Model -> Html Msg
page model =
    case model.route of
        Index ->
            Html.map UserMsg (User.view model.user)

        UsersRoute ->
            Html.map UserMsg (User.view model.user)

        LoginRoute ->
            Html.map LoginMsg (Login.view model.login)

        NotFoundRote ->
            notFoundView


notFoundView : Html Msg
notFoundView =
    let
        a =
            Debug.log "location" 1
    in
        div []
            [ text "Not found!!"
            ]
