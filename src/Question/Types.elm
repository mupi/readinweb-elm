module Question.Types exposing (..)

import Http


type alias Model =
    { question : Question
    , error : String
    }


type alias Question =
    { id : Int
    , question_header : String
    , question_text : String
    , level : String
    , author : String
    , credit_cost : Int
    , url : String
    , tags : List String
    , answers : List Answer
    }


type alias QuestionId =
    Int


type alias Answer =
    { id : Int
    , answer_text : String
    , is_corect : Bool
    }


type Msg
    = GetUser QuestionId
    | OnFetchGet (Result Http.Error Question)
    | NoOp
