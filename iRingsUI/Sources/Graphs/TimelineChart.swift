//
//  TimelineChart.swift
//  LoopLifeUI
//
//  Created by Martin Svoboda on 27.12.2025.
//  Copyright © 2025 Freedom Martin, s.r.o. All rights reserved.
//
// https://www.swiftyplace.com/blog/swiftcharts-create-charts-and-graphs-in-swiftui

import Charts
import SwiftUI
import iRingsCore

public struct TimelineChart: View {
	let vertices: [Vertex]
	let color: Color
	
	public init(vertices: [Vertex], color: Color) {
		self.vertices = vertices
		self.color = color
	}
	
	public var body: some View {
		Chart {
			ForEach(Array(vertices.enumerated()), id: \.offset) { index, item in
				if index > 0, index < vertices.count - 1 {
					LineMark(
						x: .value("", item.date),
						y: .value("", item.value)
					)
					.symbol(.circle)
				} else {
					LineMark(
						x: .value("", item.date),
						y: .value("", item.value)
					)
				}
			}
			.interpolationMethod(.monotone)
			.foregroundStyle(color)
			
			ForEach(vertices) { data in
				AreaMark(
					x: .value("", data.date),
					y: .value("", data.value)
				)
			}
			.interpolationMethod(.monotone)
			.foregroundStyle(
				LinearGradient(
					gradient: Gradient(
						colors: [
							color.opacity(0.3),
							color.opacity(0)
						]
					),
					startPoint: .top,
					endPoint: .bottom
				)
			)
		}
		.chartXAxis {
			AxisMarks(values: .stride(by: .day)) { _ in
				AxisGridLine()
				AxisValueLabel(
					format: .dateTime.day(.defaultDigits),
					centered: true,
					collisionResolution: .greedy
				)
			}
		}
		.aspectRatio(2, contentMode: .fit)
	}
}

#Preview {
	TimelineChart(
		vertices: .mock,
		color: ColorItem.mintGreen.color
	)
}
