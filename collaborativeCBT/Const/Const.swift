//
//  Const.swift
//  collaborativeCBT
//
//  Created by Subeen Park on 2021/12/05.
//

import SwiftUI

struct Const {
    
    enum LogEvent: String {
        case controlPostingStart
        case controlPostingEnd
        case controlCommentStart
        case controlCommentEnd
        case experimentPostingStart
        case experimentPostingEnd
        case experimentPostScaffoldingStart
        case experimentPostScaffoldingEnd
        case experimentCommentStart
        case experimentCommentEnd
    }

 
//    static let dummyPosts = [
//        // case #1
//        Post(emotions: ["압도감"],
//             contexts: ["연구실"],
//             body: "프로젝트 최종발표가 다가오는데 협업하는 친구가 자꾸 잠수를 타서 너무 불안해요.",
//             comments: [
//                "너무 불안하시겠네요. 저도 비슷한 경험이 있어요. 수업 최종발표인데 팀원 모두 잠수타고 저 혼자만 남겨졌을 때 그 불안함과 외로움 말로 표현 못하죠. 그래도 해결방안이 있어야 하는데 최종발표 전에 어떻게 할 생각이신가요? 저는 그때 혼자 하다가 팀원들에게 연락을 해서 어떻게 잘 마무리 되었어요."
//             ]),
//        // case #2
//        Post(emotions: ["슬픔"],
//             contexts: ["애인문제"],
//             body: "애인과 3일 전에 헤어졌어요. 사는게 사는것 같지 않아요. 벗어나려고 해도 자꾸 예전에 좋았던 기억만 떠오르고 밥 먹을 때, 해질 녘에 자꾸 애인 생각만 나서 아무것도 할 수 없어요.",
//             comments: [
//                "이별 너무 힘들어요.. 저는 금사빠라 이별이 너무 자주 있었는데 적응할 만도 한데 너무 힘들더라구요. 그럴 때 일 수록 다른 곳에 집중해 보는게 도움이 되더라구요. 어떤 일에 집중하실 수 있을까요?"
//             ]),
//        // case #3
//        Post(emotions: ["스트레스"],
//             contexts: ["금전"],
//             body: "애인과 3일 전에 헤어졌어요. 사는게 사는것 같지 않아요. 벗어나려고 해도 자꾸 예전에 좋았던 기억만 떠오르고 밥 먹을 때, 해질 녘에 자꾸 애인 생각만 나서 아무것도 할 수 없어요.",
//             comments: [
//                "돈 문제 정말 힘들죠.. 저도 매번 부모님께 의지하다가 얼마전 혼자 해결하기 시작했더니 너무 힘들더라구요. 그래도 아직 장학금을 받을지 결정이 난게 아니니까 미리 걱정하진 마세요. 최악으로 장학금을 못 탔을 때 어떤 대책이 있을지 생각해 보시면 도움될 것 같아요."
//             ]),
//        // case #4
//        Post(emotions: ["우울함"],
//             contexts: ["대학원"],
//             body: "대학원에 입학한지 엄청 오래된 것 같은데 아직 4학기라고? 이런 생각이 듭니다. 아직 갈길이 멀고 한편으로는 이렇게 될 때까지 난 뭘 한거지 하는 생각에 너무 자괴감이 들고 우울해요.",
//             comments: [
//                "저도 대학원생으로서 너무 공감이 되네요. 대학원생이 가끔 우울한 건 당연한 것 같습니다. 스트레스와 우울함을 벗어날 수 있는 활동은 하고 계신가요? 경험상 본인만의 스트레스 해소법을 찾는게 중요한 것 같아요."
//             ]),
//    ]
//    

    
    static let commentTrigger = [ "분노" : ["와 화나겠다.." , "억울했을 것 같아요ㅠㅠ" , "얼마나 화 났을까요.. "],
                                  "슬픔" : ["많이 슬프겠네요.." , "너무 허탈하겠다.." , "막막하시겠어요 ㅠㅠ" ],
                                  "불안" : ["기운 빠지시겠네요.." , "불안한 마음 때문에 지치겠어요😭" , "진 빠지겠다ㅠㅠ"] ,
                                  "당황" : ["막막하겠어요😢" , "헉..놀랐겠네요" , "당황하셨겠네요.."] ,
                                  "상처" : ["많이 속상했겠다😢" , "서운했겠네요.." , "많이 상처받으셨겠다ㅠㅠ"] ,
                                  "기쁨" : ["설렜겠네요!" , "정말 뿌듯했을 것 같아요!" , "얼마나 기분이 좋을지 상상이 돼요"],
                                  "기본" : ["힘드셨겠다.." , "막막하시겠네요ㅠㅠ"]
                                  ]
    
    
                            
      
      
      
      
    
}
