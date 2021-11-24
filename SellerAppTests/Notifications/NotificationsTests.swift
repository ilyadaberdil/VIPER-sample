//
//  NotificationsTests.swift
//  SellerAppTests
//
//  Created by Berdil Ilyada Karacam on 23.11.2021.
//

import XCTest
@testable import SellerApp

final class NotificationsTests: XCTestCase {
    
    private var presenter: NotificationsPresenter!
    private var interactor: NotificationsInteractor!

    private var router: MockNotificationsRouter!
    private var view: MockNotificationView!
    private var service: MockNotificationService!
    
    override func setUp() {
        view = MockNotificationView()
        service = MockNotificationService()
        interactor = NotificationsInteractor(service: service)
        router = MockNotificationsRouter()
        
        presenter = NotificationsPresenter(view: view,
                                           interactor: interactor,
                                           router: router)
        view.presenter = presenter
        interactor.delegate = presenter
    }
    
    func testLoadNotifications() {
        // Given
        let mockResponse = NotificationResponse.mockResponse
        service.mockNotificationResponse = mockResponse
        
        // When
        view.viewDidLoad()
        
        // Then
        XCTAssertEqual(view.outputs[0], .setLoading(true))
        XCTAssertEqual(view.outputs[1], .showStatusFilters([StatusFilter.all.rawValue,
                                                            StatusFilter.new.rawValue,
                                                            StatusFilter.read.rawValue]))
        XCTAssertEqual(view.outputs[2], .setStatusFilterPlaceholder("Durum"))
        XCTAssertEqual(view.outputs[3], .setLoading(false))
        XCTAssertEqual(view.outputs[4], .setHeader("\(mockResponse.sellerList.count) Adet Bildirim"))
        XCTAssertEqual(view.outputs[5], .setData(mockResponse.sellerList.map { NotificationCellViewModel(model: $0) }))
        XCTAssertEqual(view.outputs[6], .reloadData)
    }
    
    func testLoadNotificationsFailure() {
        // Given
        service.mockNotificationResponse = nil
        
        // When
        view.viewDidLoad()
        
        // Then
        XCTAssertEqual(view.outputs[0], .setLoading(true))
        XCTAssertEqual(view.outputs[1], .showStatusFilters([StatusFilter.all.rawValue,
                                                            StatusFilter.new.rawValue,
                                                            StatusFilter.read.rawValue]))
        XCTAssertEqual(view.outputs[2], .setStatusFilterPlaceholder("Durum"))
        XCTAssertEqual(view.outputs[3], .setLoading(false))
        XCTAssertTrue(router.isShowError)
    }
    
    func testProceedToDetail() {
        // Given
        service.mockNotificationResponse = NotificationResponse.mockResponse
        view.viewDidLoad()
        
        // When
        view.notificationTapped(at: .zero)
        
        // Then
        XCTAssertTrue(router.isProceedToDetail)
    }
    
}

