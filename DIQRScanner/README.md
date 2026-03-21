# DIQRScanner

QR Code Scanner cho iOS sử dụng **SwiftUI** + **AVFoundation**, với hiệu ứng mở rộng từ Dynamic Island.

---

## Mục lục

- [DIQRScanner](#diqrscanner)
  - [Mục lục](#mục-lục)
  - [Nguồn tham khảo \& Tôn trọng bản quyền](#nguồn-tham-khảo--tôn-trọng-bản-quyền)
  - [Quyền sử dụng, sao chép \& Miễn trừ trách nhiệm](#quyền-sử-dụng-sao-chép--miễn-trừ-trách-nhiệm)
  - [Kiến trúc tổng quan](#kiến-trúc-tổng-quan)
  - [Chi tiết từng thành phần](#chi-tiết-từng-thành-phần)
    - [1. CameraProperties](#1-cameraproperties)
    - [2. View Extension — qrScanner](#2-view-extension--qrscanner)
    - [3. QRScannerViewModified (ViewModifier)](#3-qrscannerviewmodified-viewmodifier)
    - [4. DIQRScannerView](#4-diqrscannerview)
    - [5. CameraLayerView (UIViewRepresentable)](#5-cameralayerview-uiviewrepresentable)
  - [Luồng hoạt động](#luồng-hoạt-động)
  - [Cách sử dụng cơ bản](#cách-sử-dụng-cơ-bản)
  - [Hiển thị kết quả lên UI](#hiển-thị-kết-quả-lên-ui)
  - [Lưu vào SwiftData](#lưu-vào-swiftdata)
    - [Bước 1: Tạo Model](#bước-1-tạo-model)
    - [Bước 2: Cấu hình ModelContainer trong App](#bước-2-cấu-hình-modelcontainer-trong-app)
    - [Bước 3: Lưu và hiển thị trong ContentView](#bước-3-lưu-và-hiển-thị-trong-contentview)
  - [Điểm cần chú ý khi apply cho dự án khác](#điểm-cần-chú-ý-khi-apply-cho-dự-án-khác)
    - [1. Info.plist — Quyền Camera (bắt buộc)](#1-infoplist--quyền-camera-bắt-buộc)
    - [2. iOS version tối thiểu](#2-ios-version-tối-thiểu)
    - [3. ConcentricRectangle](#3-concentricrectangle)
    - [4. Chỉ hỗ trợ thiết bị thật](#4-chỉ-hỗ-trợ-thiết-bị-thật)
    - [5. Camera session phải start/stop trên background thread](#5-camera-session-phải-startstop-trên-background-thread)
    - [6. Quét một lần rồi dừng](#6-quét-một-lần-rồi-dừng)
    - [7. Chỉ hỗ trợ QR Code](#7-chỉ-hỗ-trợ-qr-code)
    - [8. Dynamic Island](#8-dynamic-island)
    - [9. File structure khi copy sang dự án khác](#9-file-structure-khi-copy-sang-dự-án-khác)

---

## Nguồn tham khảo & Tôn trọng bản quyền

Dự án này được mình học và triển khai lại dựa trên video:

- YouTube: [SwiftUI Dynamic Island QR Code Scanner | iOS 26 | Xcode 26](https://youtu.be/RMfpocBggJg?si=Tuuq5eohz3LxlGch) by **Kavsoft**

Mục đích của phần ghi nguồn là để tôn trọng công sức tác giả nội dung gốc. Nếu bạn sử dụng lại mã nguồn trong repo này, vui lòng tiếp tục giữ tinh thần tôn trọng bản quyền đối với mọi nguồn tham khảo liên quan.

## Quyền sử dụng, sao chép & Miễn trừ trách nhiệm

Bạn có thể sử dụng, sao chép, chỉnh sửa, tích hợp, và phân phối mã nguồn trong repo này cho **bất kỳ mục đích nào** (bao gồm cá nhân, học tập, và thương mại).

Khi sử dụng mã nguồn này, bạn đồng ý rằng:

- Mã nguồn được cung cấp trên cơ sở "as is" (nguyên trạng), không có bất kỳ cam kết hoặc bảo hành nào.
- Tác giả repo không chịu trách nhiệm cho bất kỳ thiệt hại, mất mát dữ liệu, gián đoạn dịch vụ, hoặc vấn đề pháp lý phát sinh từ việc sử dụng mã nguồn.
- Người dùng tự chịu trách nhiệm kiểm tra tính phù hợp, bảo mật, và tuân thủ pháp lý trước khi đưa vào môi trường thực tế.

## Kiến trúc tổng quan

```
┌─────────────────────────────────────────────────────┐
│  ContentView                                        │
│  .qrScanner(isScanning:onScan:)  ← View Extension   │
└──────────────┬──────────────────────────────────────┘
               │ ViewModifier
┌──────────────▼──────────────────────────────────────┐
│  QRScannerViewModified                              │
│  ┌────────────────────────────────────────────────┐ │
│  │  fullScreenCover → DIQRScannerView             │ │
│  │  ┌──────────────────────────────────────────┐  │ │
│  │  │  ScannerView                             │  │ │
│  │  │  ┌────────────────────────────────────┐  │  │ │
│  │  │  │  CameraLayerView                   │  │  │ │
│  │  │  │  (UIViewRepresentable)             │  │  │ │
│  │  │  │  ┌──────────────────────────────┐  │  │  │ │
│  │  │  │  │  AVCaptureSession            │  │  │  │ │
│  │  │  │  │  AVCaptureMetadataOutput     │  │  │  │ │
│  │  │  │  │  → Delegate trả code về      │  │  │  │ │
│  │  │  │  └──────────────────────────────┘  │  │  │ │
│  │  │  └────────────────────────────────────┘  │  │ │
│  │  └──────────────────────────────────────────┘  │ │
│  └────────────────────────────────────────────────┘ │
└─────────────────────────────────────────────────────┘
```

Tất cả các struct bên trong file đều được đánh dấu `fileprivate` — chỉ expose duy nhất **View extension** `qrScanner(isScanning:onScan:)` ra ngoài.

---

## Chi tiết từng thành phần

### 1. CameraProperties

```swift
fileprivate struct CameraProperties {
    var session: AVCaptureSession = .init()
    var output: AVCaptureMetadataOutput = .init()
    var scannedCode: String?
    var permissionState: Permission?
}
```

| Property          | Mô tả                                                          |
| ----------------- | -------------------------------------------------------------- |
| `session`         | Phiên camera (`AVCaptureSession`) quản lý input/output         |
| `output`          | Đọc metadata (QR code) từ camera                               |
| `scannedCode`     | Lưu mã QR đã quét — khi giá trị thay đổi sẽ trigger `onChange` |
| `permissionState` | Trạng thái quyền camera: `.idle`, `.approved`, `.denied`       |

**`checkAndAskCameraPermission()`** — hàm `async` kiểm tra và yêu cầu quyền camera, trả về `Permission?`.

### 2. View Extension — qrScanner

```swift
extension View {
    func qrScanner(isScanning: Binding<Bool>, onScan: @escaping (String) -> Void) -> some View
}
```

Đây là **API duy nhất** được expose ra ngoài. Nhận 2 tham số:

| Tham số      | Mô tả                                       |
| ------------ | ------------------------------------------- |
| `isScanning` | `Binding<Bool>` — bật/tắt scanner           |
| `onScan`     | Closure trả về `String` khi quét thành công |

### 3. QRScannerViewModified (ViewModifier)

Đóng vai trò **cầu nối** giữa View gọi và Scanner:

- Khi `isScanning = true` → mở `fullScreenCover` (tắt animation mặc định bằng `Transaction`)
- Trình bày `DIQRScannerView` với `presentationBackground(.clear)` để giữ hiệu ứng trong suốt
- Khi scanner đóng → set `isScanning = false`

**Kỹ thuật đáng chú ý:** Sử dụng `withTransaction` với `disablesAnimations = true` để tắt animation mặc định của `fullScreenCover`, nhường chỗ cho animation custom (expand từ Dynamic Island).

### 4. DIQRScannerView

View chính chứa toàn bộ logic hiển thị scanner:

**Dynamic Island detection:**
```swift
let haveDynamicIsland: Bool = safeArea.top >= 59
```
- Nếu `safeArea.top >= 59` → thiết bị có Dynamic Island → scanner expand từ vị trí Dynamic Island
- Ngược lại → dùng offset cố định

**Luồng animation:**
1. `showContent = true` → render view (ở trạng thái thu nhỏ, kích thước Dynamic Island)
2. `isExpanding = true` → animate mở rộng ra kích thước vuông full-width
3. Khi đóng: `isExpanding = false` → thu nhỏ → `showContent = false` → stop session

**`toggle(_:)`** — điều khiển expand/collapse bằng `interpolatingSpring`, khi collapse xong sẽ stop camera session trên background thread.

**`ScannerView(_:)`** — hiển thị camera hoặc thông báo quyền bị từ chối kèm nút mở Settings.

**`scannerAnimation(_:)`** — thanh quét trắng chạy lên xuống bằng `phaseAnimator`.

### 5. CameraLayerView (UIViewRepresentable)

Bridge giữa UIKit và SwiftUI để hiển thị camera feed:

- **`makeUIView`**: Tạo `UIView` chứa `AVCaptureVideoPreviewLayer`
- **`Coordinator`**: Setup camera pipeline và implement `AVCaptureMetadataOutputObjectsDelegate`

**Camera pipeline trong Coordinator:**
```
AVCaptureDevice (back camera)
    → AVCaptureDeviceInput
        → AVCaptureSession
            → AVCaptureMetadataOutput (metadataObjectTypes: [.qr])
                → Delegate (metadataOutput didOutput)
                    → camera.scannedCode = code
```

Khi delegate nhận được QR code → gán vào `camera.scannedCode` → trigger `onChange` trong `DIQRScannerView` → gọi `onScan(code)` → tự động đóng scanner.

---

## Luồng hoạt động

```
Người dùng tap "Show Scanner"
    │
    ▼
isScanning = true
    │
    ▼
QRScannerViewModified: onChange → mở fullScreenCover (không animation)
    │
    ▼
DIQRScannerView: .task {
    showContent = true
    toggle(true)  ← expand animation
    checkAndAskCameraPermission()
}
    │
    ▼
CameraLayerView: Coordinator.setupCamera()
    - Tạo AVCaptureSession
    - Add input (back camera) + output (metadata QR)
    - session.startRunning() (background thread)
    │
    ▼
Camera chạy, thanh quét animate lên xuống
    │
    ▼
Quét được QR → metadataOutput delegate
    - camera.scannedCode = code
    │
    ▼
DIQRScannerView: onChange(camera.scannedCode)
    - onScan(code)     ← trả code về ContentView
    - toggle(false)    ← collapse animation
    │
    ▼
toggle completion:
    - session.stopRunning() (background thread)
    - showContent = false → dismiss fullScreenCover
    │
    ▼
QRScannerViewModified: onClose
    - isScanning = false
```

---

## Cách sử dụng cơ bản

```swift
import SwiftUI

struct ContentView: View {
    @State private var showScanner: Bool = false
    
    var body: some View {
        VStack {
            Button("Scan QR") {
                showScanner.toggle()
            }
        }
        .qrScanner(isScanning: $showScanner) { code in
            print("Scanned: \(code)")
        }
    }
}
```

---

## Hiển thị kết quả lên UI

```swift
import SwiftUI

struct ContentView: View {
    @State private var showScanner: Bool = false
    @State private var scannedCodes: [String] = []
    @State private var lastScannedCode: String = ""
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                // Hiển thị code vừa quét
                if !lastScannedCode.isEmpty {
                    GroupBox("Kết quả quét gần nhất") {
                        Text(lastScannedCode)
                            .font(.body.monospaced())
                            .textSelection(.enabled)
                    }
                }
                
                Button("Quét QR Code") {
                    showScanner = true
                }
                .buttonStyle(.borderedProminent)
                
                // Danh sách lịch sử
                List(scannedCodes, id: \.self) { code in
                    Text(code)
                        .font(.caption.monospaced())
                }
            }
            .navigationTitle("QR Scanner")
            .qrScanner(isScanning: $showScanner) { code in
                lastScannedCode = code
                scannedCodes.insert(code, at: 0)
            }
        }
    }
}
```

---

## Lưu vào SwiftData

### Bước 1: Tạo Model

```swift
import Foundation
import SwiftData

@Model
final class ScannedQR {
    var code: String
    var scannedAt: Date
    
    init(code: String, scannedAt: Date = .now) {
        self.code = code
        self.scannedAt = scannedAt
    }
}
```

### Bước 2: Cấu hình ModelContainer trong App

```swift
import SwiftUI
import SwiftData

@main
struct DIQRScannerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: ScannedQR.self)
    }
}
```

### Bước 3: Lưu và hiển thị trong ContentView

```swift
import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var showScanner: Bool = false
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \ScannedQR.scannedAt, order: .reverse) private var scannedQRs: [ScannedQR]
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    Button("Quét QR Code") {
                        showScanner = true
                    }
                }
                
                Section("Lịch sử quét") {
                    ForEach(scannedQRs) { qr in
                        VStack(alignment: .leading, spacing: 4) {
                            Text(qr.code)
                                .font(.body.monospaced())
                                .textSelection(.enabled)
                            Text(qr.scannedAt, style: .relative)
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                    }
                    .onDelete { indexSet in
                        for index in indexSet {
                            modelContext.delete(scannedQRs[index])
                        }
                    }
                }
            }
            .navigationTitle("QR Scanner")
            .qrScanner(isScanning: $showScanner) { code in
                let newQR = ScannedQR(code: code)
                modelContext.insert(newQR)
            }
        }
    }
}
```

---

## Điểm cần chú ý khi apply cho dự án khác

### 1. Info.plist — Quyền Camera (bắt buộc)

Thêm key sau vào `Info.plist`, nếu thiếu app sẽ **crash ngay lập tức**:

```xml
<key>NSCameraUsageDescription</key>
<string>Ứng dụng cần quyền camera để quét mã QR</string>
```

### 2. iOS version tối thiểu

- **iOS 17.0+** — bắt buộc do sử dụng:
  - `phaseAnimator` (iOS 17+)
  - `onChange(of:) { oldValue, newValue in }` (iOS 17+)
  - `ConcentricRectangle` (custom shape, cần kiểm tra dependency)

### 3. ConcentricRectangle

Code sử dụng `ConcentricRectangle` — đây **không phải** API mặc định của SwiftUI. Bạn cần:
- Kiểm tra xem đây là shape custom hay từ thư viện bên thứ ba
- Nếu không có, thay thế bằng `RoundedRectangle` thông thường:

```swift
// Thay thế:
ConcentricRectangle(corners: .concentric(minimum: .fixed(30)), isUniform: true)
// Bằng:
RoundedRectangle(cornerRadius: 30, style: .continuous)
```

### 4. Chỉ hỗ trợ thiết bị thật

`AVCaptureSession` **không hoạt động trên iOS Simulator**. Cần test trên thiết bị thật.

### 5. Camera session phải start/stop trên background thread

```swift
// ✅ Đúng
DispatchQueue.global(qos: .background).async {
    session.startRunning()
}

// ❌ Sai — sẽ block main thread
session.startRunning()
```

### 6. Quét một lần rồi dừng

Code hiện tại chỉ quét **1 lần** rồi tự đóng scanner. Nếu muốn quét liên tục, cần:
- Bỏ guard `parent.camera.scannedCode == nil` trong delegate
- Reset `scannedCode = nil` sau mỗi lần xử lý
- Không gọi `toggle(false)` sau khi quét

### 7. Chỉ hỗ trợ QR Code

```swift
output.metadataObjectTypes = [.qr]
```

Nếu cần hỗ trợ thêm barcode khác, thêm vào mảng:
```swift
output.metadataObjectTypes = [.qr, .ean13, .ean8, .code128]
```

### 8. Dynamic Island

- Hiệu ứng expand từ Dynamic Island chỉ hoạt động đẹp trên iPhone 14 Pro trở lên
- Trên các thiết bị không có Dynamic Island, scanner xuất hiện từ top với offset cố định
- Cần test trên cả 2 loại thiết bị

### 9. File structure khi copy sang dự án khác

```
YourProject/
├── Helpers/
│   └── DIQRScannerView.swift    ← Copy file này
├── Info.plist                    ← Thêm NSCameraUsageDescription
└── ContentView.swift             ← Gọi .qrScanner(...)
```

Chỉ cần copy **1 file duy nhất** (`DIQRScannerView.swift`) là đủ — toàn bộ logic được đóng gói bên trong.
