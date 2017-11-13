//
//  DetailViewController.swift
//  sampleMiniGuidebook
//
//  Created by Eriko Ichinohe on 2017/11/10.
//  Copyright © 2017年 Eriko Ichinohe. All rights reserved.
//

import UIKit
import MapKit

class DetailViewController: UIViewController {

    //前の画面から受け取るためのプロパティ
    var getAreaName = ""
    
    @IBOutlet weak var textDesc: UITextView!
    
    @IBOutlet weak var areaImage: UIImageView!
    
    @IBOutlet weak var areaMap: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("getAreaName:\(getAreaName)")
        
        //ファイルパスを取得（エリア名が格納されているプロパティリスト）
        let filePath = Bundle.main.path(forResource: "areaList", ofType: "plist")
        
        //ファイルの内容を読み込んでディクショナリー型に格納
        let dic = NSDictionary(contentsOfFile: filePath!)

        //今画面に表示したいデータの取得
        let detailInfo = dic![getAreaName] as! NSDictionary
        
        //Dictionaryからキー指定で取り出すとかならずAny型になるのでダウンキャスト変換が必要
        print(detailInfo["description"] as! String)
        print(detailInfo["image"] as! String)
        print(detailInfo["latitude"] as! String)
        print(detailInfo["longitude"] as! String)

        //タイトル
//        areaTitle.text = getAreaName
        
        //タイトルを、ナビゲーションバーの真ん中に表示
        navigationItem.title = getAreaName
//        self.title = getAreaName
        
        //これ↓動かない
//        navigationController?.title = getAreaName
        
        //説明
        textDesc.text = detailInfo["description"] as! String
        
        //画像
        areaImage.image = UIImage(named:detailInfo["image"] as! String)
        
        //地図
        let latitude = detailInfo["latitude"] as! String
        let longitude = detailInfo["longitude"] as! String
        
        //座標オブジェクト
        //型変換　String型->Double型
        let coodinate = CLLocationCoordinate2DMake(atof(latitude), atof(longitude))
        
        //拡縮率
        let span = MKCoordinateSpanMake(0.04, 0.04)
        
        //範囲オブジェクト
        let region = MKCoordinateRegionMake(coodinate, span)
        
        //地図にセット
        areaMap.setRegion(region, animated: true)
        
        //ピンを生成
        let myPin:MKPointAnnotation = MKPointAnnotation()
        myPin.coordinate = coodinate
        myPin.title = getAreaName
        
        areaMap.addAnnotation(myPin)
        
    }
    
    
    var contentOffset = CGPoint.zero
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        textDesc.contentOffset = contentOffset //set
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        contentOffset = textDesc.contentOffset //keep
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        contentOffset = CGPoint.zero //init
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
