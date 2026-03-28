# Advanced Navigation for SwiftUI apps

## Nguồn tham khảo & Tôn trọng bản quyền

Dự án này được mình học và triển khai lại dựa trên video:

- YouTube: [Advanced Navigation for SwiftUI apps](https://youtu.be/Z-3ETLYbhFA?si=IMh722Hf-1XKsqqr) by **Crafting Swift**
- Full sample code của video có thể xem tại GitHub của tác giả [movie-catalog-routing/00-routing-and-deep-links](https://github.com/fespinoza/CraftingSwift-SampleProjects/pull/4).

Mục đích của phần ghi nguồn là để tôn trọng công sức tác giả nội dung gốc. Nếu bạn sử dụng lại mã nguồn trong repo này, vui lòng tiếp tục giữ tinh thần tôn trọng bản quyền đối với mọi nguồn tham khảo liên quan.

## Quyền sử dụng, sao chép & Miễn trừ trách nhiệm

Bạn có thể sử dụng, sao chép, chỉnh sửa, tích hợp, và phân phối mã nguồn trong repo này cho **bất kỳ mục đích nào** (bao gồm cá nhân, học tập, và thương mại).

Khi sử dụng mã nguồn này, bạn đồng ý rằng:

- Mã nguồn được cung cấp trên cơ sở "as is" (nguyên trạng), không có bất kỳ cam kết hoặc bảo hành nào.
- Tác giả repo không chịu trách nhiệm cho bất kỳ thiệt hại, mất mát dữ liệu, gián đoạn dịch vụ, hoặc vấn đề pháp lý phát sinh từ việc sử dụng mã nguồn.
- Người dùng tự chịu trách nhiệm kiểm tra tính phù hợp, bảo mật, và tuân thủ pháp lý trước khi đưa vào môi trường thực tế.

---

## Vấn đề với Navigation mặc định của SwiftUI

SwiftUI cung cấp ba loại transition chính: **Tab**, **Push** (NavigationStack), và **Full Screen/Sheet**.  Tuy nhiên, cách triển khai mặc định tồn tại 3 vấn đề nghiêm trọng:

- **Tight coupling**: View nguồn (origin) biết quá nhiều về view đích (destination) — ví dụ `NavigationLink` phải khai báo thẳng `destination` view ngay tại chỗ
- **Code duplication**: Nhiều view khác nhau muốn navigate đến cùng một destination phải copy-paste lại state và modifier (`sheet`, `fullScreenCover`)
- **Deep linking khó**: Khi parse URL để điều hướng vào đúng màn hình, lại phải lặp lại logic present view ở nhiều nơi

---

## Giải pháp: Router-based Navigation

Felipe đề xuất một hệ thống gồm **5 thành phần** kết hợp với nhau:

### 1. `Destination` enum (trung tâm hóa điểm đến)

Định nghĩa một `enum Destination` bao gồm tất cả các loại điều hướng của app — bên trong chia thành `PushDestination`, `SheetDestination`, `FullScreenDestination`. Mỗi case có thể mang **associated value** (ví dụ: `movieDetails(id: String)`).  Đây là nguồn dữ liệu duy nhất (single source of truth) cho tất cả điểm đến.

### 2. Hàm Mapping `destination → View`

Một pure function nhận vào một `Destination` value và trả về `View` tương ứng.  Mọi logic "destination nào → render view gì" được tập trung ở đây, không bị phân tán khắp codebase.

### 3. `Router` (quản lý state điều hướng)

`Router` là một object chứa các `@State` property tương ứng với từng kiểu navigation.  Khi muốn điều hướng, chỉ cần **set state** trên router, phần còn lại tự động xảy ra. Router còn hỗ trợ **cây phân cấp** (parent/child router) — router con bubble up event nếu không tự xử lý được.

### 4. `NavigationContainer` (vùng bọc có router riêng)

Thay vì dùng `NavigationStack` trực tiếp, dùng `NavigationContainer` — nó wrap một `NavigationStack`, giữ một `Router` instance, set tất cả `.sheet` / `.fullScreenCover` modifier, và inject router vào **SwiftUI Environment**.  Mỗi Sheet hay FullScreen được present sẽ tự động tạo một `NavigationContainer` mới với router con riêng.

### 5. `NavigationButton` (thay thế `NavigationLink`)

Component này đọc router từ Environment và gọi set state phù hợp.  Khác `NavigationLink` ở chỗ nó hoạt động với **tất cả loại transition** (push, sheet, fullscreen, tab), không chỉ push.

---

## Deep Linking & Universal Links trở nên đơn giản

Với hệ thống trên, deep link chỉ cần thêm một **pure function**: `deepLinkDestinationFromURL(url:)` — nhận URL, parse, trả về `Destination` value.  Sau đó chỉ cần set destination đó vào **active router** (router nào đang hiển thị trên màn hình sẽ được đánh dấu active qua `onAppear`/`onDisappear`).  Việc test cũng rất dễ vì đây là pure function.

---

## Sơ đồ kiến trúc tổng thể

```markdown
RootTabView (RootRouter)
├── Tab 1: NavigationContainer (Router A — child of RootRouter)
│     ├── MovieListView
│     └── [push] MovieDetailView  ← NavigationButton set Router A state
├── Tab 2: NavigationContainer (Router B)
│
└── [sheet] NavigationContainer (Router C — child of Router A)
        └── ActorDetailView
```

### MovieApp

```markdown
MovieApp/
├── App/
│   └── MovieApp.swift              # Entry point
├── Navigation/
│   ├── Destination.swift           # ① Destination enum
│   ├── DestinationMapper.swift     # ② Mapping function
│   ├── Router.swift                # ③ Router (state manager)
│   ├── NavigationContainer.swift   # ④ NavigationContainer
│   └── NavigationButton.swift      # ⑤ NavigationButton
├── Models/
│   └── Movie.swift
└── Views/
    ├── RootTabView.swift
    ├── HomeView.swift
    ├── SearchView.swift
    ├── MovieDetailView.swift
    ├── ActorDetailView.swift
    └── FavoriteView.swift

```

---

## Use Cases có thể áp dụng

| Use Case                                     | Lý do phù hợp                                                                                                             |
| -------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------- |
| **App có nhiều màn hình dùng chung**         | Một destination như `movieDetail(id:)` có thể được navigate từ SearchView, HomeView, FavoriteView mà không duplicate code |
| **Deep link / Push Notification navigation** | Parse URL → Destination → set active router, không cần viết lại present logic                                             |
| **Backend-driven navigation**                | Backend trả về deep link URL hoặc destination string, app tự động điều hướng đúng màn hình                                |
| **App quy mô lớn, nhiều team**               | Mỗi team chỉ cần thêm case vào `Destination` enum và mapping function, không đụng vào view của team khác                  |
| **Testability**                              | Logic mapping URL → Destination là pure function, dễ unit test hoàn toàn tách biệt với UI                                 |

---

## Tại sao approach này tốt hơn?

- **Decoupling hoàn toàn**: View nguồn không cần biết View đích trông như thế nào
- **Zero duplication**: Thêm destination mới chỉ cần 2 bước: thêm case vào enum + thêm mapping, dùng được từ **bất kỳ đâu** trong app
- **Scalable**: Phù hợp cho production app lớn, đã được kiểm chứng thực tế
