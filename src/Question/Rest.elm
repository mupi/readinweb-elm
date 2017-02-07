module Question.Rest exposing (..)

import Http
import Json.Decode as Decode exposing (field)
import Json.Decode.Pipeline exposing (decode, required, optional)
import Question.Type exposing (..)


url : QuestionId -> String
url questionId =
    String.concat [ "http://localhost:8000/rest/questions/", (toString questionId), "/" ]


answerDecoder : Decode.Decoder Answer
answerDecoder =
    Decode.map3 Answer
        (field "id" Decode.int)
        (field "answer_text" Decode.string)
        (field "is_correct" Decode.bool)


questionsDecoder : Decode.Decoder (List Question)
questionsDecoder =
    Decode.list questionDecoder


questionDecoder : Decode.Decoder Question
questionDecoder =
    decode Question
        |> required "id" Decode.int
        |> required "question_header" Decode.string
        |> required "question_text" Decode.string
        |> required "level" Decode.string
        |> required "author" Decode.string
        |> required "credit_cost" Decode.int
        |> required "url" Decode.string
        |> required "tags" (Decode.list Decode.string)
        |> optional "answers" (Decode.list answerDecoder) []


getQuestion : QuestionId -> Http.Request Question
getQuestion questionId =
    Http.get (url questionId) questionDecoder


fetchGet : QuestionId -> Cmd Msg
fetchGet questionId =
    Http.send OnFetchGet (getQuestion questionId)
