//
//  ParticleScene.swift
//  SpriteKitSnow
//
//  Created by Алексей Авдейчик on 22.12.21.
//

import Foundation
import SpriteKit

class ParticleScene: SKScene {
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        setupParticleEmitter()
    }
    
    private func setupParticleEmitter() {
        let particleEmitter = SKEmitterNode(fileNamed: "Snow")!
        particleEmitter.position = CGPoint(x: 1080, y: 1920)
        addChild(particleEmitter)
    }
}
