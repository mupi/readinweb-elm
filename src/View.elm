module View exposing (..)

import Html exposing (..)
import Html.App
import Html.Attributes exposing (..)
import Type exposing (..)
import Cadastro.View as Cadastro exposing (..)


-- import View


view : Model -> Html Msg
view model =
    div [ class "container" ]
        [ div [ class "jumbotron text-left" ]
            [ Html.App.map CadastroMsg (Cadastro.registerForm model.cadastro)
            ]
        ]
