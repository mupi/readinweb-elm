module Question.Types exposing (..)

import Http


type alias Model =
    { question : Question
    , questionPage : QuestionPage
    , error : String
    }


type alias Question =
    { id : Int
    , question_header : String
    , question_text : String
    , level : Maybe String
    , author : String
    , credit_cost : Int
    , url : String
    , tags : List String
    , answers : List Answer
    }


type alias QuestionPage =
    { count : Int
    , actual : Int
    , next : Maybe String
    , previous : Maybe String
    , questions : List Question
    }


type alias QuestionId =
    Int


type alias PageNumber =
    Int


type alias Answer =
    { id : Int
    , answer_text : String
    , is_corect : Bool
    }


type Msg
    = GetQuestion QuestionId
    | GetQuestionPage PageNumber
    | PreviousPage PageNumber
    | NextPage PageNumber
    | OnFetchGetQuestion (Result Http.Error Question)
    | OnFetchGetQuestionPage (Result Http.Error QuestionPage)
    | NoOp
