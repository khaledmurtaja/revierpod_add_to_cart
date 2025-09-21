# Add to Cart - Flutter E-commerce App

A Flutter e-commerce application that demonstrates a complete "Add to Cart" flow with product customization options. This app is built using MVVM architecture with Riverpod for state management.

## Features

### 🍽️ Product Selection
- Browse meals in a beautiful grid layout
- Search functionality to find specific meals
- High-quality images with loading states
- Favorite items (UI ready)

### ⚙️ Product Customization
- Multiple option types:
  - **Single Selection** (Radio buttons) - Required and optional
  - **Multiple Selection** (Checkboxes) - Add-ons and extras
- Price-determining options that set the base price
- Real-time price calculation
- Required field validation

### 🛒 Shopping Cart
- Add items with custom options to cart
- Prevent duplicate items with identical configurations
- Different options create separate cart items
- Quantity management with pulse animations
- Remove items functionality
- Real-time total calculation

### 🎨 UI/UX Features
- Modern Material Design 3
- Purple accent color theme
- Smooth animations and transitions
- Pulse animation on quantity buttons
- Responsive design
- Loading states and error handling

## Architecture

### MVVM Pattern
- **Models**: Data classes for meals, options, cart items
- **Views**: Flutter widgets and screens
- **ViewModels**: Riverpod providers and notifiers

### State Management
- **Riverpod**: For reactive state management
- **Providers**: Separate providers for meals, cart, and selected options
- **StateNotifiers**: For complex state operations

### Key Components

#### Models
- `Meal`: Product information with options
- `Option`: Configuration options (size, add-ons, etc.)
- `OptionValue`: Individual option choices
- `CartItem`: Items in the shopping cart
- `SelectedOption`: User's option selections

#### Screens
- `CategoryScreen`: Main product listing
- `AddToCartModal`: Product customization modal
- `CartScreen`: Shopping cart management

#### Widgets
- `MealCard`: Product display card
- `OptionSelector`: Option selection UI
- `QuantitySelector`: Quantity management with animations
- `CartItemCard`: Cart item display

## Getting Started

### Prerequisites
- Flutter SDK (3.8.0 or higher)
- Dart SDK
- Android Studio / VS Code

### Installation

1. Clone the repository
2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Generate JSON serialization code:
   ```bash
   flutter packages pub run build_runner build
   ```

4. Run the app:
   ```bash
   flutter run
   ```

## Project Structure

```
lib/
├── models/                 # Data models
│   ├── meal.dart
│   ├── option.dart
│   ├── option_value.dart
│   ├── selected_option.dart
│   ├── cart_item.dart
│   └── cart.dart
├── repositories/           # Data access layer
│   ├── meals_repository.dart
│   └── cart_repository.dart
├── providers/             # State management
│   ├── meals_provider.dart
│   ├── cart_provider.dart
│   └── selected_options_provider.dart
├── screens/               # UI screens
│   ├── category_screen.dart
│   ├── add_to_cart_modal.dart
│   └── cart_screen.dart
├── widgets/               # Reusable components
│   └── common/
│       ├── meal_card.dart
│       ├── option_selector.dart
│       ├── quantity_selector.dart
│       └── cart_item_card.dart
└── main.dart              # App entry point
```

## Data Source

The app uses a local JSON file (`lib/meals (1).json`) that contains:
- 6 different seafood meals
- Various customization options
- Price information
- Product descriptions and images

## Key Features Implementation

### Cart Logic
- Items are uniquely identified by meal + selected options combination
- Different option selections create separate cart entries
- Quantity management preserves option selections
- Real-time price calculation

### Option System
- **Required Single**: Must select one option (e.g., pasta type)
- **Optional Single**: Can select one option (e.g., sauce)
- **Optional Multiple**: Can select multiple options (e.g., add-ons)
- **Price Determining**: Sets the base price of the meal

### Animations
- Pulse animation on quantity selector buttons
- Smooth transitions between screens
- Loading states for images and data

## Dependencies

- `flutter_riverpod`: State management
- `cached_network_image`: Image loading and caching
- `json_annotation`: JSON serialization
- `json_serializable`: Code generation for JSON

## Future Enhancements

- [ ] User authentication
- [ ] Order history
- [ ] Payment integration
- [ ] Push notifications
- [ ] Offline support
- [ ] Dark mode
- [ ] Multiple languages

## License

This project is for demonstration purposes.