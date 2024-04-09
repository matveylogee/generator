//
//  Resources.swift
//  generator
//
//  Created by Матвей on 17.03.2024.
//

import Foundation

enum Resources {
    
    enum LicenceTitles: String {
        case titleTypeOfLeasing = ""
        case masterUse = "Мастер использования. "
        case mechanicalRights = "Механические права. "
        case performanceRights = "Права на исполнение. "
        case synchronizationRights = "Права на синхронизацию. "
        case consideration = "Рассмотрение. "
        case delivery = "Доставка. "
        case audioSamples = "Семплы. "
        case governingLaw = "Применимое право. "
    }
    
    enum TitleTypeOfLeasing: Int {
        case mp3 = 0, wav, trackout
            
        var description: String {
            switch self {
            case .mp3:
                return "MP3"
                    
            case .wav:
                return "WAV"
                    
            case .trackout:
                return "TRACKOUT"
            }
        }
    }
        
    enum MasterUse: String {
        
        case description = "Лицензиар настоящим предоставляет Лицензии неисключительную лицензию (настоящая «Лицензия») на запись вокальной синхронизации Композиции частично или полностью и по существу в ее первоначальной форме («Основная запись»)."
    }
        
    enum MechanicalRights: String {
        
        case description = "Лицензиар настоящим предоставляет Лицензиату неисключительную лицензию на использование основной записи при воспроизведении, копировании, производстве и распространении фонографических записей, кассет, компакт-дисков, цифровых загрузок, других различных аудио- и цифровых записей, а также любых лифтов и версий. их (в совокупности «Записи» и по отдельности «Записи») по всему миру до выпуска или продажи в общей сложности 100000 копий таких Записей или любой комбинации таких Записей, при условии выплаты Лицензиару суммы в размере (price) рублей РФ, получение которых подтверждено."
    }
        
    enum PerformanceRights: Int {
        case mp3 = 0, wav, trackout
            
        var description: String {
            switch self {
            case .mp3:
                return """
                Лицензиар предоставляет Лицензиату неисключительную лицензию Mp3 на использование Основной записи в неограниченных некоммерческих выступлениях, шоу или концертах. Лицензиат не может получить компенсацию за исполнение с этой лицензией.
                """
                    
            case .wav:
                return """
                Лицензиар предоставляет Лицензиату неисключительную лицензию Wav на использование Основной записи в неограниченных некоммерческих выступлениях, шоу или концертах. Лицензиат не может получить компенсацию за исполнение с этой лицензией.
                """
                    
            case .trackout:
                return """
                Лицензиар предоставляет Лицензиату неисключительную лицензию Trackout на использование Основной записи в неограниченных некоммерческих выступлениях, шоу или концертах. Лицензиат не может получить компенсацию за исполнение с этой лицензией.
                """
            }
        }
    }
    
    enum SynchronizationRights: Int {
        case mp3 = 0, wav, trackout
            
        var description: String {
            switch self {
            case .mp3:
                return """
                Лицензиар предоставляет ограниченные права на синхронизацию одного (1) музыкального видео, транслируемого онлайн (Youtube, Vimeo и т. Д.), Общим количеством до 500 000 потоков на всех веб-сайтах.
                """
                    
            case .wav:
                return """
                Лицензиар предоставляет ограниченные права на синхронизацию одного (1) музыкального видео, транслируемого онлайн (Youtube, Vimeo и т. Д.), Общим количеством до 900 000 потоков на всех веб-сайтах.
                """
                    
            case .trackout:
                return """
                Лицензиар предоставляет ограниченные права на синхронизацию одного (1) музыкального видео, транслируемого онлайн (Youtube, Vimeo и т. Д.), Общим количеством до 1 500 000 потоков на всех веб-сайтах.
                """
            }
        }
    }
        
    enum Consideration: String {
        
        case description = "В качестве вознаграждения за права, предоставленные по настоящему соглашению, Лицензиат уплачивает лицензиару сумму в размере (price) рублей РФ, получение которого настоящим подтверждается. Если Лицензиат не отчитывается перед Лицензиаром, своевременно не выполняет платежи, предусмотренные настоящим Соглашением, или не выполняет свои другие обязательства по настоящему Соглашению, включая недостаточный банковский баланс, лицензиар имеет право прекратить действие Лицензии, направив Лицензиату письменное уведомление."
    }

    enum Delivery: String {
        
        case description = "Композиция будет доставлена по электронной почте на адрес электронной почты, который Лицензиат предоставил Лицензиару. Лицензиат получит электронное письмо с вложением или ссылкой, по которой он может загрузить Композицию."
    }
    
    enum AudioSamples: String {
        
        case description = "За оформление образцов третьей стороной отвечает Лицензиат."
    }

    enum GoverningLaw: String {
        
        case description = "Настоящая Лицензия регулируется и подлежит толкованию в соответствии с Российским законодательством. \n \nСТОРОНЫ ОБЯЗАТЕЛЬНО ИСПОЛНИЛИ НАСТОЯЩЕЕ СОГЛАШЕНИЕ в дату, указанную выше."
    }
    
}