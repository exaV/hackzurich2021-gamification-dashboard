module Challenges exposing (..)

import Chart as C
import Chart.Attributes as CA
import Chart.Item as CI
import Html.Styled exposing (..)
import Html.Styled.Attributes as Attr
import Html.Styled.Events
import Http as Http
import Json.Decode exposing (string)
import Json.Encode exposing (Value)
import Tailwind.Utilities as Tw
import Url.Builder



-- MODEL


type alias Challenge =
    { id : String, title : String, description : String, challengeType : String }


type alias ChallengeDetails =
    { id : String, entries : List ChallengeEntry }


type alias ChallengeEntry =
    { value : Float, user : User }


type alias ChallengWithEntries =
    ( Challenge, List ChallengeEntry )


type ChallengeData
    = Just Challenge
    | WithEntries ChallengWithEntries


extractChallenge : ChallengeData -> Challenge
extractChallenge data =
    case data of
        Just challenge ->
            challenge

        WithEntries ( challenge, _ ) ->
            challenge


type alias User =
    { id : String, username : String }


challengeEncoder : Challenge -> Json.Encode.Value
challengeEncoder challenge =
    Json.Encode.object
        [ ( "id", Json.Encode.string challenge.id )
        , ( "title", Json.Encode.string challenge.title )
        , ( "description", Json.Encode.string challenge.description )
        , ( "challengeType", Json.Encode.string challenge.challengeType )
        ]


challengeDecoder : Json.Decode.Decoder Challenge
challengeDecoder =
    Json.Decode.map4 Challenge
        (Json.Decode.field "id" string)
        (Json.Decode.field "title" string)
        (Json.Decode.field "description" string)
        (Json.Decode.field "challengeType" string)


challengeEntryDecoder : Json.Decode.Decoder ChallengeEntry
challengeEntryDecoder =
    Json.Decode.map2 ChallengeEntry
        (Json.Decode.field "value" Json.Decode.float)
        (Json.Decode.field "user" userDecoder)


userDecoder : Json.Decode.Decoder User
userDecoder =
    Json.Decode.map2 User
        (Json.Decode.field "id" string)
        (Json.Decode.field "username" string)



-- from http bin - only works while online
--getChallenges : Cmd Msg
--getChallenges =
--    Http.post
--        { url = absolute [ "api", "challenges" ] []
--        , body = Http.stringBody "application/json" (Json.Encode.encode 0 (challengeEncoder exampleChallenge))
--        , expect = Http.expectJson GotChallenge (field "json" challengeDecoder)
--        }


getChallenges : Cmd Msg
getChallenges =
    Http.get
        { url = Url.Builder.absolute [ "api", "challenges" ] []
        , expect = Http.expectJson GotChallenge (Json.Decode.list challengeDecoder)
        }


getChallengeDetails : Challenge -> Cmd GotChallengeEntries
getChallengeDetails challenge =
    Http.get
        { url = Url.Builder.absolute [ "api", "challenges", challenge.id, "entries" ] []
        , expect = Http.expectJson GotChallengeEntries (Json.Decode.list challengeEntryDecoder)
        }


type GotChallengeEntries
    = GotChallengeEntries (Result Http.Error (List ChallengeEntry))



-- UPDATE


type Msg
    = GotChallenge (Result Http.Error (List Challenge))
    | GotChallengeDetails (Result Http.Error ChallengeDetails)
    | Increment
    | Decrement
    | LoadChallengeDetails Challenge
    | ShowChallengeDetails (Maybe ChallengeData)



-- VIEW


viewChallengeDetailsModal : Maybe ChallengeData -> Html Msg
viewChallengeDetailsModal model =
    case model of
        Nothing ->
            div [] []

        Maybe.Just a ->
            viewChallengeDetailsModalOpen a


viewChallengeDetailsModalOpen : ChallengeData -> Html Msg
viewChallengeDetailsModalOpen model =
    div [ Attr.css [ Tw.fixed, Tw.w_screen, Tw.min_h_screen, Tw.z_10, Tw.inset_0, Tw.overflow_y_auto ], Html.Styled.Events.onClick (ShowChallengeDetails (Maybe.Just model)) ]
        [ div [ Attr.css [ Tw.min_h_screen, Tw.items_center, Tw.text_center, Tw.flex, Tw.flex_col, Tw.bg_gray_100, Tw.bg_opacity_50 ] ]
            [ div [ Attr.css [ Tw.flex_1 ] ] []
            , div [ Attr.css [ Tw.flex_1, Tw.rounded, Tw.bg_white, Tw.p_10, Tw.w_1over2 ] ]
                [ viewChallengeDetails model
                ]
            , div [ Attr.css [ Tw.flex_1 ] ] []
            ]
        ]


viewChallengeDetails : ChallengeData -> Html Msg
viewChallengeDetails model =
    div [ Attr.css [ Tw.inline_block, Tw.w_full ] ]
        [ table [ Attr.css [ Tw.w_full ] ]
            [ thead []
                [ td [] [ text "User" ]
                , td [] [ text "Score" ]
                ]
            , tbody [ Attr.css [] ]
                (case model of
                    Just _ ->
                        []

                    WithEntries ( _, entries ) ->
                        List.map (\x -> viewUserDataAsRow x) entries
                )
            ]
        , div [] []
        , div []
            []
        ]


viewUserDataAsRow : ChallengeEntry -> Html Msg
viewUserDataAsRow entry =
    tr []
        [ td [] [ text (String.fromFloat entry.value) ]
        , td [] [ text entry.user.username ]
        ]


viewChallengesGrid : List ChallengeData -> Html Msg
viewChallengesGrid model =
    div [ Attr.css [ Tw.grid, Tw.grid_flow_col, Tw.gap_4 ] ]
        (List.map (\x -> viewChallenge x) model)


viewChallenge : ChallengeData -> Html Msg
viewChallenge model =
    div [ Attr.css [ Tw.inline_flex, Tw.flex_col, Tw.rounded_md, Tw.shadow, Tw.p_6, Tw.items_center ], Html.Styled.Events.onClick (ShowChallengeDetails (Maybe.Just model)) ]
        [ div [ Attr.css [ Tw.text_xl, Tw.font_medium, Tw.text_black, Tw.text_center ] ] [ text (extractChallenge model).title ]
        , p [ Attr.css [ Tw.text_gray_500 ] ] [ text (extractChallenge model).description ]

        -- todo loading spinner
        , div [ Attr.css [ Tw.p_5, Tw.w_20, Tw.h_20 ] ]
            [ case model of
                Just challenge ->
                    button [ Html.Styled.Events.onClick (LoadChallengeDetails challenge) ]
                        [ text "loading..." ]

                WithEntries challengWithEntries ->
                    viewChallengeChart challengWithEntries
            ]
        ]


viewChallengeChart : ChallengWithEntries -> Html msg
viewChallengeChart ( challenge, entries ) =
    Html.Styled.fromUnstyled <|
        C.chart
            [ CA.height 300
            , CA.width 300
            ]
            [ C.bars []
                [ C.bar .value [] ]
                entries
            , C.binLabels (\x -> x.user.username) [ CA.moveDown 15 ]
            , C.binLabels (\x -> String.fromFloat x.value) [ CA.position CI.getTop, CA.moveUp 5 ]
            ]
