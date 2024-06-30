import UIKit
import SceneKit

class PlaneSceneView: SCNView {
    
    private var planeNode: SCNNode!
    
    override init(frame: CGRect, options: [String : Any]? = nil) {
        super.init(frame: frame, options: options)
        setupScene()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupScene()
    }
    
    private func setupScene() {
        let scene = SCNScene()
        self.scene = scene
        self.allowsCameraControl = true
        self.autoenablesDefaultLighting = true
        
        // Plane 노드 생성
        let planeGeometry = SCNPlane(width: 1, height: 1)
        planeGeometry.firstMaterial?.diffuse.contents = UIColor.blue
        planeNode = SCNNode(geometry: planeGeometry)
        planeNode.position = SCNVector3(0, 0, -5)
        planeNode.name = "interactivePlane"
        scene.rootNode.addChildNode(planeNode)
        
        // Tap Gesture Recognizer 설정
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        self.addGestureRecognizer(tapGesture)
    }
    
    @objc private func handleTap(_ gestureRecognize: UIGestureRecognizer) {
        let p = gestureRecognize.location(in: self)
        let hitResults = self.hitTest(p, options: [:])
        
        if let hitResult = hitResults.first {
            if hitResult.node.name == "interactivePlane" {
                // Plane 객체와 상호작용
                showListViewControllerOnPlane()
            }
        }
    }
    
    private func showListViewControllerOnPlane() {
        // ListViewController를 생성
        let listViewController = ListViewController()
        
        // SceneKit에서 사용할 노드 생성
        let planeViewNode = UIViewNode(view: listViewController.view)
        
        // 현재 SceneKit 뷰의 기준 좌표계에서 평면의 위치 계산
        let planePosition = planeNode.convertPosition(SCNVector3Zero, to: self.scene?.rootNode)
        planeViewNode.position = SCNVector3(planePosition.x, planePosition.y + 0.5, planePosition.z) // Y 좌표는 필요에 따라 조정
        
        // 기존의 서브노드 제거
        planeNode.childNodes.forEach { $0.removeFromParentNode() }
        
        // 새로운 뷰 노드 추가
        planeNode.addChildNode(planeViewNode)
    }
}

// SceneKit에서 UIView를 사용할 수 있도록 래핑하는 클래스
class UIViewNode: SCNNode {
    
    init(view: UIView) {
        super.init()
        
        let plane = SCNPlane(width: view.bounds.width / 20.0, height: view.bounds.height / 20.0) // 사이즈 조정 필요
        
        let material = SCNMaterial()
        material.diffuse.contents = view
        plane.materials = [material]
        
        geometry = plane
        eulerAngles.x = -.pi / 2
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
