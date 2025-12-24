//
//  ActivitiesRepository.swift
//  Activity
//
//  Created by Martin Svoboda on 11.07.2025.
//  Copyright © 2025 Freedom Martin, s.r.o. All rights reserved.
//

import Foundation
import Combine

public protocol ActivitiesRepositoring {
	func activities() -> AnyPublisher<[Activity], Error>
	func activityLogs(ids: [ActivityLog]) -> AnyPublisher<[ActivityLog], Error>
	
	func activity(id: Activity.ID) -> AnyPublisher<Activity, Error>
	func activityLog(id: ActivityLog.ID) -> AnyPublisher<ActivityLog, Error>
	
	func save(activity: Activity) throws
	
	func recordLog(for activity: Activity, date: Date?, completionRatio: CGFloat, note: String?) throws
	
	func deleteActivity(id: Activity.ID) throws
	func deleteActivityLog(id: ActivityLog.ID) throws
}

public extension ActivitiesRepositoring {
	func recordLog(
		for activity: Activity,
		date: Date? = nil,
		completionRatio: CGFloat = 1,
		note: String? = nil
	) throws {
		try recordLog(
			for: activity,
			date: date,
			completionRatio: completionRatio,
			note: note
		)
	}
}

final class ActivitiesRepository: BaseRepository, ActivitiesRepositoring {
	
	private var activitiesSubject = PassthroughSubject<[Activity], Error>()
	private var activityLogsSubject = PassthroughSubject<[ActivityLog], Error>()
	
	private var activitySubject = PassthroughSubject<Activity, Error>()
	private var activityLogSubject = PassthroughSubject<ActivityLog, Error>()
	
	// MARK: - Init
	
	override init(coreDataManager: CoreDataManaging) {
		super.init(coreDataManager: coreDataManager)
	}
	
	// MARK: - Public API
	
	func activities() -> AnyPublisher<[Activity], Error> {
		activitiesSubject.onReceiveSubscription { [unowned self] _ in
			loadItems(subject: activitiesSubject)
		}
	}
	
	func activityLogs(ids: [ActivityLog]) -> AnyPublisher<[ActivityLog], Error> {
		activityLogsSubject.onReceiveSubscription { [unowned self] _ in
			loadItems(subject: activityLogsSubject)
		}
	}
	
	func activity(id: Activity.ID) -> AnyPublisher<Activity, Error> {
		activitySubject.onReceiveSubscription { [unowned self] _ in
			loadItem(id: id, subject: activitySubject)
		}
	}
	
	func activityLog(id: ActivityLog.ID) -> AnyPublisher<ActivityLog, Error> {
		activityLogSubject.onReceiveSubscription { [unowned self] _ in
			loadItem(id: id, subject: activityLogSubject)
		}
	}
	
	func save(activity: Activity) throws {
		try saveItem(item: activity)
	}
	
	func recordLog(for activity: Activity, date: Date?, completionRatio: CGFloat, note: String?) throws {
		var activity = activity
		
		let newLog = activity.newLog(
			date: date,
			completionRatio: completionRatio,
			note: note
		)
		
		try saveItem(item: newLog)
		try saveItem(item: activity)
		
		// Refresh activities
		loadItems(subject: activitiesSubject)
	}
	
	func save(activityLog: ActivityLog) throws {
		try saveItem(item: activityLog)
	}
	
	func deleteActivity(id: Activity.ID) throws {
		try deleteItem(id: id, entityType: Activity.entityType)
	}
	
	func deleteActivityLog(id: ActivityLog.ID) throws {
		try deleteItem(id: id, entityType: ActivityLog.entityType)
	}
}
