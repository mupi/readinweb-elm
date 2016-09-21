module View exposing (..)

import Html exposing (..)
import Html.App
import Html.Attributes exposing (..)
import Type exposing (..)


-- My Modules

import Register.View as Register exposing (..)


view : Model -> Html Msg
view model =
    div [ class "container" ]
        [ div [ class "jumbotron text-left" ]
            [ case model.status of
                Register ->
                    Html.App.map RegisterMsg (Register.view model.register)

                _ ->
                    div [] []
            ]
        , p [] [ text (toString model) ]
        ]
