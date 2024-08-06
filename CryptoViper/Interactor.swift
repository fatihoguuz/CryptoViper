//
//  Interactor.swift
//  CryptoViper
//
//  Created by Fatih Oğuz on 2.08.2024.
//

import Foundation

// Class
// Protocol
// Talks To -> Presenter

protocol AnyInteractor {
    
    var presenter: AnyPresenter? {get set}
    
    func downloadCryptos()
        
    
   
}
class CryptoInteractor : AnyInteractor {
    var presenter: AnyPresenter?
    
    func downloadCryptos() {
        guard let url = URL(string: "https://raw.githubusercontent.com/atilsamancioglu/IA32-CryptoComposeData/main/cryptolist.json") else{
            return
        }
        let task = URLSession.shared.dataTask(with: url) {[weak self] data , response, error  in
            guard let data = data, error == nil else {
                self?.presenter?.interactorDidDownloadCrypto(result: .failure(NetworkError.NetworkFailed))
                return
                
            }
            do {
                let cryptos = try JSONDecoder().decode([Crypto].self, from: data)
                self?.presenter?.interactorDidDownloadCrypto(result: .success(cryptos) )
            }catch {
                self?.presenter?.interactorDidDownloadCrypto(result: .failure(NetworkError.ParsingFailed))
            }
        }
        
        task.resume()
    }
    
    
}
