//
//  HomeVC.swift
//  FirstRxSwift
//
//  Created by Tolga İskender on 3.10.2020.
//  Copyright © 2020 Tolga İskender. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

struct City {
    let country: String?
    let cities: [String]?
}
enum CellModel {
    case city(String)
    case country(City)
}

class HomeVC: UIViewController, UIScrollViewDelegate {
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.estimatedRowHeight = UITableView.automaticDimension
            tableView.rowHeight = UITableView.automaticDimension
            tableView.register(SubtitleTableViewCell.self, forCellReuseIdentifier: "cell")
            tableView.tableFooterView = UIView(frame: .zero)
        }
    }
    typealias SectionOfCities = SectionModel<String,CellModel>
    
    var country = SectionOfCities(model: "Country", items: [
        CellModel.country(City(country: "Canada", cities: ["Toronto","Quebec","Vancouver","Ottawa"])),
        CellModel.country(City(country: "Turkey", cities: ["Istanbul","Sakarya","Ankara","Trabzon"]))
    ])
    let city =
        SectionOfCities(model: "City", items: [CellModel.city("Istanbul"),
                                            CellModel.city("Sakarya"),
                                            CellModel.city("Ankara"),
                                            CellModel.city("Trabzon"),
                                            CellModel.city("Toronto"),
                                            CellModel.city("Quebec"),
                                            CellModel.city("Vancouver"),
                                            CellModel.city("Ottawa")])
    
    let items = PublishSubject<[SectionOfCities]>()
    let disposeBag = DisposeBag()
    
    let dataSource = RxTableViewSectionedReloadDataSource<SectionOfCities>(
        configureCell: { (_, tv, indexPath, section) in
            switch section {
            case .city(let city):
                let cell = tv.dequeueReusableCell(withIdentifier: "cell")!
                cell.textLabel?.text = city
                return cell
            case .country(let country):
                let cell = tv.dequeueReusableCell(withIdentifier: "cell")!
                cell.textLabel?.text = country.country
                var allCities:String = ""
                country.cities?.forEach({ (city) in
                    allCities += "\(city),"
                })
                cell.detailTextLabel?.text = String(allCities.dropLast())
                return cell
            }
    },
        titleForHeaderInSection: { dataSource, sectionIndex in
            return dataSource[sectionIndex].model
    }
    )
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigation()
        bind()
    }
    fileprivate func setUpNavigation(){
        self.title = "Cities"
    }
    fileprivate func bind(){
        items
            .bind(to: tableView.rx.items(dataSource: self.dataSource))
            .disposed(by: disposeBag)
        
        Observable
            .zip(tableView.rx.itemSelected, tableView.rx.modelSelected(CellModel.self))
            .bind { [unowned self] indexPath, sectionModel in
                switch sectionModel {
                case .city(let city):
                    if let cell = self.tableView.cellForRow(at: indexPath) as? SubtitleTableViewCell {
                        cell.textLabel?.text = "\(city ) Selected"
                    }
                case .country(let country):
                    if let cell = self.tableView.cellForRow(at: indexPath) as? SubtitleTableViewCell {
                        cell.textLabel?.text = "\(country.country ?? "" ) Selected"
                    }
                }
                
        }.disposed(by: disposeBag)
        
        items.onNext([city,country])
    }
}
