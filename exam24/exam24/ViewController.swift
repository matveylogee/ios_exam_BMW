//
//  ViewController.swift
//  exam24
//
//  Created by Матвей on 19.03.2024.
//

import UIKit

class ViewController: UIViewController {

    var calendarData: [[String]] = [] // Пустой массив для данных календаря

    let mainScrollView = UIScrollView()
    var horizontalScrollViews: [UIScrollView] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white

        for month in 1...12 {
            for day in 1...30 { // Изменили количество дней на 30
                var dayOfMonth = day
                if let monthName = getMonthName(month: month), let dayOfWeek = getDayOfWeek(day: day) {
                    calendarData.append([monthName, "Day \(dayOfMonth)", dayOfWeek])
                }
            }
        }

        mainScrollView.frame = view.bounds
        mainScrollView.contentSize = CGSize(width: view.bounds.width, height: view.bounds.height * 3)
        mainScrollView.delegate = self
        view.addSubview(mainScrollView)

        for i in 0..<3 {
            let horizontalScrollView = UIScrollView()
            horizontalScrollView.frame = CGRect(x: 0, y: view.bounds.height * CGFloat(i), width: view.bounds.width, height: view.bounds.height)
            horizontalScrollView.contentSize = CGSize(width: view.bounds.width * CGFloat(calendarData.count), height: view.bounds.height)
            horizontalScrollView.delegate = self

            // Добавление заголовка
            let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 50))
            titleLabel.textColor = UIColor.black
            titleLabel.textAlignment = .center
            titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
            titleLabel.text = "Year \(2023 + i)"
            horizontalScrollView.addSubview(titleLabel)

            for j in 0..<calendarData.count {
                let cardView = UIView(frame: CGRect(x: view.bounds.width * CGFloat(j) + 100, y: 100, width: view.bounds.width / 2, height: view.bounds.height / 4))
                cardView.backgroundColor = .lightGray

                let calendarImage = UIImageView(frame: CGRect(x: 10, y: 10, width: 30, height: 30))
                calendarImage.image = UIImage(systemName: "calendar")
                calendarImage.tintColor = .black
                cardView.addSubview(calendarImage)

                let label = UILabel(frame: CGRect(x: 50, y: 0, width: cardView.frame.width - 50, height: cardView.frame.height))
                label.text = calendarData[j].joined(separator: "\n")
                label.textColor = .black
                label.numberOfLines = 0
                cardView.addSubview(label)

                horizontalScrollView.addSubview(cardView)
            }

            mainScrollView.addSubview(horizontalScrollView)
            horizontalScrollViews.append(horizontalScrollView)
        }
    }
    
    // Функция для получения названия месяца
    func getMonthName(month: Int) -> String? {
        guard month >= 1 && month <= 12 else { return nil }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        return dateFormatter.monthSymbols[month - 1]
    }
    
    // Функция для получения дня недели
        func getDayOfWeek(day: Int) -> String? {
            guard day >= 1 && day <= 7 else { return nil }
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "EEEE"
            let date = DateComponents(year: 2023, month: 1, day: day)
            if let date = Calendar.current.date(from: date) {
                return dateFormatter.string(from: date)
            }
            return nil
        }
}

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == mainScrollView {
            let currentPage = Int(scrollView.contentOffset.y / scrollView.bounds.height)
            if currentPage == 0 {
                // Обновление данных для предыдущего года
            } else if currentPage == 2 {
                // Обновление данных для следующего года
            }
        }
    }
}
