module Question.View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (id, type_, for, value, class)
import Html.Events exposing (..)
import Question.Type exposing (..)
import Markdown


view : Model -> Html Msg
view model =
    let
        question =
            model.question
    in
        div [ id "signup-form" ]
            [ Html.h1 [] [ text "User Details" ]
            , p [] [ text (toString question.id) ]
            , p [] [ text question.question_header ]
            , p [] [ Markdown.toHtml [] question.question_text ]
            , p [] [ text question.level ]
            , p [] [ text (toString question.credit_cost) ]
            , p [] [ text (toString question.tags) ]
            , p [] [ text (toString question.answers) ]
            , text (toString model)
            ]
