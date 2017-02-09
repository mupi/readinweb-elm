module Question.View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (id, type_, for, value, class)
import Html.Events exposing (..)
import Question.Types exposing (..)
import Markdown
import Navigation


view : Model -> Html Msg
view model =
    let
        question =
            model.question
    in
        div []
            [ questionView question
            , text (toString model)
            ]


questionView : Question -> Html Msg
questionView question =
    div []
        [ Html.h1 [] [ text "Question" ]
        , p [] [ text (toString question.id) ]
        , p [] [ text question.question_header ]
        , p [] [ Markdown.toHtml [] question.question_text ]
        , p []
            [ text
                (case question.level of
                    Just level ->
                        level

                    Nothing ->
                        ""
                )
            ]
        , p [] [ text (toString question.credit_cost) ]
        , p [] [ text (toString question.tags) ]
        , p [] [ text (toString question.answers) ]
        ]


viewQuestionPage : Model -> Html Msg
viewQuestionPage model =
    let
        page =
            model.questionPage
    in
        div []
            [ questionPageHeader page
            , div [] (List.map questionView page.questions)
            ]


questionPageHeader : QuestionPage -> Html Msg
questionPageHeader page =
    div []
        [ case page.previous of
            Just previous ->
                (button [ onClick <| PreviousPage (page.actual - 1) ] [ text "< page" ])

            Nothing ->
                text ""
        , p
            []
            [ text (String.concat [ "Questions Page ", toString page.actual ]) ]
        , case page.next of
            Just next ->
                (button [ onClick <| NextPage (page.actual + 1) ] [ text "page >" ])

            Nothing ->
                text ""
        ]
