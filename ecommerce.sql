-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 07, 2025 at 06:15 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ecommerce`
--

-- --------------------------------------------------------

--
-- Table structure for table `accounts`
--

CREATE TABLE `accounts` (
  `username` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_vietnamese_ci NOT NULL,
  `password` varchar(100) NOT NULL,
  `user_id` varchar(7) CHARACTER SET utf8mb4 COLLATE utf8mb4_vietnamese_ci NOT NULL,
  `cart_id` varchar(100) NOT NULL,
  `account_type` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `accounts`
--

INSERT INTO `accounts` (`username`, `password`, `user_id`, `cart_id`, `account_type`) VALUES
('*', '*', '0', 'GUEST0001', 'Non-user'),
('jasmine', 'Sumika123@', 'CUS0011', '6d1c5859550824d403d8c31af9ac673b7ba206e6f87e61e096a017299f74d63f', 'client');

-- --------------------------------------------------------

--
-- Table structure for table `cart`
--

CREATE TABLE `cart` (
  `ID` varchar(100) NOT NULL,
  `No. products` int(11) NOT NULL,
  `Total price` double NOT NULL DEFAULT 0,
  `Customer ID` varchar(7) CHARACTER SET utf8mb4 COLLATE utf8mb4_vietnamese_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `cart`
--

INSERT INTO `cart` (`ID`, `No. products`, `Total price`, `Customer ID`) VALUES
('6d1c5859550824d403d8c31af9ac673b7ba206e6f87e61e096a017299f74d63f', 0, 0, 'CUS0011'),
('GUEST0001', 1, 9000000010000, '0');

-- --------------------------------------------------------

--
-- Table structure for table `cart has items`
--

CREATE TABLE `cart has items` (
  `Cart ID` varchar(100) NOT NULL,
  `Item ID` varchar(10) NOT NULL,
  `Quantity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `comment`
--

CREATE TABLE `comment` (
  `id` varchar(7) NOT NULL,
  `user_id` varchar(7) NOT NULL,
  `content` text NOT NULL,
  `date_posted` datetime NOT NULL,
  `like_count` int(11) NOT NULL DEFAULT 0,
  `post_id` varchar(7) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci;

--
-- Dumping data for table `comment`
--

INSERT INTO `comment` (`id`, `user_id`, `content`, `date_posted`, `like_count`, `post_id`) VALUES
('', 'CUS0001', 'Quá hay! Cảm ơn bạn đã chia sẻ', '0000-00-00 00:00:00', 0, 'POS0001'),
('', 'CUS0001', 'Quá hay! Cảm ơn bạn đã chia sẻ', '0000-00-00 00:00:00', 0, 'POS0001'),
('', 'CUS0001', 'Quá hay! Cảm ơn bạn đã chia sẻ', '0000-00-00 00:00:00', 0, 'POS0001'),
('', 'CUS0001', 'Quá hay! Cảm ơn bạn đã chia sẻ', '2025-04-29 12:35:00', 0, 'POS0001'),
('COM0001', 'CUS0002', 'Quá hay! Cảm ơn bạn đã chia sẻ', '2025-04-29 12:35:00', 0, NULL),
('COM0002', 'CUS0002', 'Quá hay! Cảm ơn bạn đã chia sẻ', '2025-04-29 12:35:00', 0, 'POS0002'),
('COM0003', 'CUS0001', 'jldkfjsfw', '2025-05-07 03:23:20', 0, 'POS0001'),
('COM0004', 'CUS0001', 'Gớm\n', '2025-05-07 03:23:34', 0, 'POS0001');

--
-- Triggers `comment`
--
DELIMITER $$
CREATE TRIGGER `TriggerGenerateNewId` BEFORE INSERT ON `comment` FOR EACH ROW BEGIN
    DECLARE next_id INT DEFAULT 0;
    DECLARE formatted_id VARCHAR(7);

    -- 1. Find the highest existing numeric part of COM IDs
    SELECT
        IFNULL(MAX(CAST(SUBSTRING(id, 4) AS UNSIGNED)), 0) INTO next_id
    FROM
        comment
    WHERE
        id LIKE 'COM%';

    -- 2. Increment the numeric part
    SET next_id = next_id + 1;

    -- 3. Format the ID
    SET formatted_id = CONCAT('COM', LPAD(next_id, 4, '0'));

    -- 4. Assign the new ID to the 'id' column of the new row
    SET NEW.id = formatted_id;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `faqs`
--

CREATE TABLE `faqs` (
  `id` int(11) NOT NULL,
  `question` text NOT NULL,
  `answer` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `faqs`
--

INSERT INTO `faqs` (`id`, `question`, `answer`, `created_at`, `updated_at`) VALUES
(1, 'Làm thế nào để đặt hàng trên RCQ?', 'Để đặt hàng trên RCQ, bạn cần thực hiện các bước sau:\n1. Đăng nhập vào tài khoản RCQ\n2. Tìm kiếm sản phẩm bạn muốn mua\n3. Thêm sản phẩm vào giỏ hàng\n4. Kiểm tra giỏ hàng và chọn phương thức thanh toán\n5. Xác nhận đơn hàng và chờ xác nhận từ chúng tôi', '2025-05-07 16:11:16', '2025-05-07 16:11:16'),
(2, 'Các phương thức thanh toán được chấp nhận?', 'RCQ chấp nhận nhiều phương thức thanh toán:\n- Thanh toán khi nhận hàng (COD)\n- Chuyển khoản ngân hàng\n- Ví điện tử (Momo, ZaloPay, VNPay)\n- Thẻ tín dụng/ghi nợ quốc tế', '2025-05-07 16:11:16', '2025-05-07 16:11:16'),
(3, 'Thời gian giao hàng là bao lâu?', 'Thời gian giao hàng phụ thuộc vào địa điểm của bạn:\n- Nội thành Hà Nội/HCM: 1-2 ngày làm việc\n- Các tỉnh/thành phố khác: 2-4 ngày làm việc\n- Vùng sâu, vùng xa: 4-7 ngày làm việc', '2025-05-07 16:11:16', '2025-05-07 16:11:16'),
(4, 'Chính sách đổi trả hàng như thế nào?', 'RCQ có chính sách đổi trả hàng trong vòng 7 ngày kể từ khi nhận hàng:\n- Sản phẩm phải còn nguyên seal, chưa qua sử dụng\n- Có đầy đủ hóa đơn và phiếu bảo hành\n- Không áp dụng với một số sản phẩm đặc biệt', '2025-05-07 16:11:16', '2025-05-07 16:11:16'),
(5, 'Làm sao để theo dõi đơn hàng?', 'Bạn có thể theo dõi đơn hàng bằng cách:\n1. Đăng nhập vào tài khoản RCQ\n2. Vào mục \"Đơn hàng của tôi\"\n3. Chọn đơn hàng cần theo dõi\n4. Xem trạng thái và thông tin vận chuyển', '2025-05-07 16:11:16', '2025-05-07 16:11:16'),
(6, 'Có được kiểm tra hàng trước khi nhận không?', 'Có, bạn có thể kiểm tra hàng trước khi nhận. Tuy nhiên, bạn chỉ được:\n- Kiểm tra bên ngoài sản phẩm\n- Kiểm tra số lượng\n- Không được mở seal sản phẩm', '2025-05-07 16:11:16', '2025-05-07 16:11:16'),
(7, 'Làm thế nào để liên hệ hỗ trợ khách hàng?', 'Bạn có thể liên hệ hỗ trợ khách hàng qua:\n- Hotline: 1900-xxxx\n- Email: support@rcq.com\n- Chat trực tuyến trên website\n- Fanpage RCQ', '2025-05-07 16:11:16', '2025-05-07 16:11:16'),
(8, 'Có chương trình khuyến mãi nào không?', 'RCQ thường xuyên có các chương trình khuyến mãi:\n- Giảm giá theo mùa\n- Mã giảm giá cho thành viên mới\n- Chương trình tích điểm\n- Flash sale hàng tuần', '2025-05-07 16:11:16', '2025-05-07 16:11:16'),
(9, 'Làm sao để trở thành đối tác bán hàng?', 'Để trở thành đối tác bán hàng trên RCQ, bạn cần:\n1. Đăng ký tài khoản đối tác\n2. Cung cấp giấy tờ pháp lý\n3. Đăng sản phẩm lên hệ thống\n4. Chờ xét duyệt từ RCQ', '2025-05-07 16:11:16', '2025-05-07 16:11:16'),
(10, 'Có chính sách bảo hành không?', 'RCQ có chính sách bảo hành như sau:\n- Sản phẩm điện tử: 12-24 tháng\n- Sản phẩm thời trang: 30 ngày\n- Sản phẩm gia dụng: 12 tháng\n- Thời gian bảo hành có thể khác nhau tùy nhà sản xuất', '2025-05-07 16:11:16', '2025-05-07 16:11:16');

-- --------------------------------------------------------

--
-- Table structure for table `invoice`
--

CREATE TABLE `invoice` (
  `ID` int(11) NOT NULL,
  `Cart ID` varchar(100) NOT NULL,
  `Time_order` datetime NOT NULL DEFAULT current_timestamp(),
  `Full Name` text NOT NULL,
  `City/Province` text NOT NULL,
  `District` text NOT NULL,
  `Ward` text NOT NULL,
  `Address` text NOT NULL,
  `Email` text NOT NULL,
  `Phone number` varchar(10) NOT NULL,
  `Pay_method` text NOT NULL,
  `Total_price` float NOT NULL,
  `Status` varchar(50) NOT NULL DEFAULT 'pending'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `invoice`
--

INSERT INTO `invoice` (`ID`, `Cart ID`, `Time_order`, `Full Name`, `City/Province`, `District`, `Ward`, `Address`, `Email`, `Phone number`, `Pay_method`, `Total_price`, `Status`) VALUES
(32, 'GUEST0001', '2025-05-06 00:00:00', 'Võ Thị B', 'TP. HCM', 'Củ Chi', 'Tân Thông Hội', '5 đường Suối Lội, ấp Bàu Sim', 'beB@gmail.com', '0193234144', 'cash', 11408800, 'delivering'),
(33, 'GUEST0001', '2025-05-06 00:00:00', 'Nguyễn Văn Bím', 'TP. HCM', 'Củ Chi', 'Tân Phú Trung', '3/12 đường số 86, ấp Xóm Đồng', 'sth@example.com', '0923918324', 'cash', 17054800, 'received'),
(34, 'GUEST0001', '2025-05-06 00:00:00', 'Võ Thị Nguyệt', 'TP. HCM', 'Củ Chi', 'Tân Phú Trung', '3/49 đường số 86, ấp Xóm Đồng', 'vothinguyet@gmail.com', '0776421022', 'cash', 18001000, 'delivering'),
(35, 'GUEST0001', '2025-05-07 00:00:00', 'Nguyễn Văn A', 'Bình Dương', 'Long Thành', 'Dĩ An', '3/12 đường số 86, ấp Xóm Đồng', 'sth@example.com', '0923918324', 'cash', 79750, 'received'),
(36, 'GUEST0001', '2025-05-07 09:55:16', 'Nguyễn Văn A', 'TP. HCM', 'Củ Chi', 'Tân Phú Trung', '3/12 đường số 86, ấp Xóm Đồng', 'sth@example.com', '0923918324', 'cash', 42150000, 'pending'),
(37, 'GUEST0001', '2025-05-07 21:36:29', 'Nguyễn Văn A', 'TP. HCM', 'Long Thành', 'Tân Thông Hội', '3/12 đường số 86, ấp Xóm Đồng', 'sth@example.com', '0923918324', 'cash', 34206400, 'pending'),
(38, 'GUEST0001', '2025-05-07 22:30:23', 'Toan Minh Nguyen', 'Phnom Penh', 'Tam Thái Tử', 'xldkfj', 'qwefqf2332', 'sth@example.com', '0923918324', 'cash', 9000000000000, 'pending'),
(39, 'GUEST0001', '2025-05-07 22:30:24', 'Toan Minh Nguyen', 'Phnom Penh', 'Tam Thái Tử', 'xldkfj', 'qwefqf2332', 'sth@example.com', '0923918324', 'cash', 9000000000000, 'pending');

-- --------------------------------------------------------

--
-- Table structure for table `invoice has items`
--

CREATE TABLE `invoice has items` (
  `Invoice ID` int(11) NOT NULL,
  `Cart ID` varchar(10) NOT NULL,
  `Item ID` varchar(10) NOT NULL,
  `Quantity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `invoice has items`
--

INSERT INTO `invoice has items` (`Invoice ID`, `Cart ID`, `Item ID`, `Quantity`) VALUES
(32, 'GUEST0001', 'LT0112', 1),
(33, 'GUEST0001', 'LT0123', 1),
(34, 'GUEST0001', 'LT0101', 1),
(35, 'GUEST0001', 'GD0101', 3),
(36, 'GUEST0001', 'LT0118', 1),
(37, 'GUEST0001', 'LT0112', 3),
(38, 'GUEST0001', 'GD0102', 1);

--
-- Triggers `invoice has items`
--
DELIMITER $$
CREATE TRIGGER `update_item_quantity_after_insert` AFTER INSERT ON `invoice has items` FOR EACH ROW UPDATE `items`
SET `items`.`Quantity` = `items`.`Quantity` -  NEW.`Quantity`
WHERE `items`.`ID` = NEW.`Item ID`
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `items`
--

CREATE TABLE `items` (
  `ID` varchar(10) NOT NULL,
  `Product Name` text NOT NULL,
  `Description` text DEFAULT NULL,
  `Price` float DEFAULT NULL,
  `Discount` float DEFAULT NULL,
  `Rating` int(5) NOT NULL,
  `Image Src` text NOT NULL,
  `Item_type_id` varchar(10) NOT NULL,
  `Brand` text NOT NULL,
  `Quantity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `items`
--

INSERT INTO `items` (`ID`, `Product Name`, `Description`, `Price`, `Discount`, `Rating`, `Image Src`, `Item_type_id`, `Brand`, `Quantity`) VALUES
('GD0101', 'Nước tương Maggi', 'Nước tương chính hãng', 25000, 0.09, 4, 'http://localhost/images/Nước%20tương%20đậu%20nành%20Maggi%20thanh%20dịu%20chai%20nắp%20%20vàng%20200ml-Maggi%20Soy%20Sauce%20Mild.jpg', 'GD', 'Maggi', 23),
('GD0102', 'Minh Toàn', '23424', 10000000000000, 0.1, 2, 'http://localhost/images/z5541122871703_4083c67bb3a413912498e98a5f6ad89d.jpg', 'GD', 'BKMC', 0),
('LT0101', 'Laptop Acer Nitro 5 - Eagle', 'Sở hữu thiết kế góc cạnh đầy mạnh mẽ cùng hiệu năng ấn tượng, Acer Nitro 5 – Eagle là lựa chọn hoàn hảo cho game thủ muốn “chiến” hết mình mà không lo ngại về giá. Trang bị Intel Core i5 thế hệ 11, đi kèm card đồ họa rời NVIDIA RTX 3050 Ti, laptop này mang đến trải nghiệm chơi game mượt mà, đồ họa sống động, xử lý đa nhiệm nhanh chóng.\r\n\r\nMàn hình 15.6 inch FHD tần số quét 144Hz giúp bạn không bỏ lỡ bất kỳ khoảnh khắc nào trên chiến trường ảo. Cùng với hệ thống tản nhiệt kép CoolBoost thông minh, máy luôn giữ nhiệt độ ổn định dù bạn “cày game” hàng giờ liền.\r\n\r\nBàn phím LED đỏ cá tính, ổ SSD 512GB tốc độ cao, RAM nâng cấp linh hoạt, kết nối đa dạng – Nitro 5 Eagle không chỉ là một chiếc laptop, mà là người bạn đồng hành lý tưởng của mọi game thủ hiện đại.\r\n\r\nAcer Nitro 5 Eagle – Đã chất game, còn chất giá!', 19990000, 0.1, 2, 'http://localhost/images/Acer%20Nitro%205%20-%20pour%20pièces.jpg', 'LT', 'Acer', 499),
('LT0102', 'Laptop Acer Nitro 5 - Tiger', 'Được trang bị vi xử lý Intel Core i5-12500H thế hệ 12 cùng card đồ họa NVIDIA GeForce RTX 3050 4GB, Nitro 5 Tiger xử lý tốt các tựa game phổ biến hiện nay và các tác vụ đồ họa nặng. Với RAM 8GB DDR4 (có thể nâng cấp lên đến 32GB) và ổ cứng SSD 512GB NVMe, máy đảm bảo tốc độ khởi động nhanh và không gian lưu trữ rộng rãi.', 18990000, 0, 3, 'http://localhost/images/Laptop%20Acer%20Nitro%205%20AN515%2058%2078PT%20Intel%20core%20i7%2012700H%2016GB%20SSD%20512GB.jpg', 'LT', 'Acer', 500),
('LT0112', 'Laptop ASUS Vivobook 15 X1504ZA-NJ517W', 'Dòng laptop ASUS Vivobook nổi bật với thiết kế trẻ trung, hiệu năng ổn định và giá cả hợp lý, phù hợp cho học sinh, sinh viên và người đi làm. Với nhiều phiên bản đa dạng, từ cấu hình cơ bản đến cao cấp, Vivobook đáp ứng tốt nhu cầu học tập, làm việc văn phòng và giải trí hàng ngày.\r\n\r\n', 12390000, 0.08, 2, 'http://localhost/images/ASUS%20Vivobook%2016%2016_%20FHD+%20Laptop%20Intel%20Core%20i5%201235U%20with%2016GB%20Memory%20512GB%20SSD%20Cool%20Silver%20F1605ZA-AS56.jpg', 'LT', 'Asus', 491),
('LT0114', 'Asus ROG Zephyrus G14 GA403 (2024)', 'Cuộc chạy đua giữa các dòng laptop gaming vào đầu năm nay chưa có dấu hiệu hạ nhiệt khi mới đây Asus tiếp tục cho ra mắt dòng sản phẩm Asus ROG Zephyrus G14 GA403 với ngoại hình đẹp mắt, có tính di động cao, màn hình OLED sắc nét cùng hiệu năng mạnh mẽ với bộ vi xử lý AMD Ryzen 9 cùng card RTX 4000 series, giúp nó cân trọn mọi tựa game AAA hay ứng dụng đồ họa chuyên nghiệp nào. ', 54490000, 0.13, 3, 'http://localhost/images/ASUS%20ROG%20Zephyrus%20G16%20GU603VV-N4119W%20Intel%20Core%20i7%20i7-13620H%20Computer%20portatile%2040,6%20cm%20(16_)%20WQXGA%2016%20GB%20DDR4-SDRAM%201%20TB%20SSD%20NVIDIA%20GeForce%20RTX%204060%20Wi-Fi%206E%20(802_11ax)%20Windows%2011%20Home%20Grigio.jpg', 'LT', 'Asus', 500),
('LT0118', 'Laptop Dell XPS 14 9440 2024 Core Ultra 7-155H RAM 32GB SSD 1TB 3K OLED', 'Được trang bị bộ vi xử lý Intel Core Ultra 7-155H với 16 lõi và tốc độ tối đa lên đến 4.8 GHz, cùng với 32GB RAM LPDDR5X và ổ cứng SSD 1TB, máy đảm bảo khả năng xử lý mượt mà các tác vụ nặng như chỉnh sửa video, thiết kế đồ họa và chơi game. \r\n', 49000000, 0.14, 3, 'http://localhost/images/Dell%20Xps%2014%209440%20(2024).jpg', 'LT', 'Dell', 498),
('LT0121', 'Laptop Dell Inspiron 15 3520', 'Dell Inspiron 15 3520 (N5I5057W1) là mẫu laptop tầm trung nổi bật năm 2024, được thiết kế để đáp ứng nhu cầu học tập, làm việc và giải trí hàng ngày. Với cấu hình mạnh mẽ và nhiều tính năng tiện ích, sản phẩm này phù hợp cho sinh viên, nhân viên văn phòng và người dùng phổ thông.\r\nMáy được trang bị bộ vi xử lý Intel Core i5-1235U thế hệ 12 với 10 lõi (2 hiệu năng cao + 8 tiết kiệm điện), kết hợp cùng 16GB RAM DDR4 và ổ cứng SSD 512GB NVMe, đảm bảo khả năng xử lý nhanh chóng các tác vụ văn phòng, học tập và giải trí nhẹ nhàng. Card đồ họa tích hợp Intel Iris Xe Graphics hỗ trợ tốt cho các công việc đồ họa cơ bản và xem video chất lượng cao.', 16990000, 0.05, 3, 'http://localhost/images/Notebook%20Dell%20Inspiron%20i15-3501-A50P%2015_6_%20HD%2011ª%20Geração%20Intel%20Core%20i5%208GB%20256GB%20SSD%20NVIDIA%20GeForce%20Windows%2010%20Preto,Black.jpg', 'LT', 'Dell', 500),
('LT0123', 'Laptop HP Gaming VICTUS 15', 'Máy được trang bị bộ vi xử lý Intel Core i5-1335U thế hệ 13 với 10 lõi (2 hiệu năng cao và 8 tiết kiệm điện), kết hợp cùng 8GB RAM DDR4 và ổ cứng SSD 512GB, đảm bảo khả năng xử lý mượt mà các tác vụ văn phòng, học tập và giải trí nhẹ nhàng.', 25440000, 0.33, 4, 'http://localhost/images/HP%20Victus%20Gaming%20Laptop,.jpg', 'LT', 'HP', 499),
('LT0124', 'Laptop Dell Vostro 3530', 'Máy được trang bị bộ vi xử lý Intel Core i5-1335U thế hệ 13 với 10 lõi (2 hiệu năng cao và 8 tiết kiệm điện), kết hợp cùng 8GB RAM DDR4 và ổ cứng SSD 512GB, đảm bảo khả năng xử lý mượt mà các tác vụ văn phòng, học tập và giải trí nhẹ nhàng.', 16490000, 0.05, 4, 'https://i.postimg.cc/wMDxK0bW/Laptop-Dell-Vostro-3530-V5-I5267-W1-i5-8-GB-256-GB-15-6.jpg', 'LT', 'Dell', 500),
('MT1092', 'Nước tương Maggi', 'afdfsf', 12000, 0, 2, 'http://localhost/images/Nước%20tương%20đậu%20nành%20Maggi%20thanh%20dịu%20chai%20nắp%20%20vàng%20200ml-Maggi%20Soy%20Sauce%20Mild.jpg', 'GD', 'Maggi', 1),
('SP0121', 'Samsung Galaxy A51', 'asfwef', 18490000, 0.1, 1, 'http://localhost/Forms_Example/upload/Samsung%20Galaxy%20A51.jpg', 'SP', 'Samsung', 11);

--
-- Triggers `items`
--
DELIMITER $$
CREATE TRIGGER `update_type_quantity_after_update` AFTER UPDATE ON `items` FOR EACH ROW UPDATE `item type`
SET `item type`.`Num_products` = `item type`.`Num_products` + NEW.`Quantity`
WHERE `item type`.`Item_type_id` = NEW.`Item_type_id`
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `update_type_quantity_on_delete` AFTER DELETE ON `items` FOR EACH ROW UPDATE `item type`
SET `item type`.`Num_products` = `item type`.`Num_products` - OLD.`Quantity`
WHERE `Item_type_id` = OLD.`Item_type_id`
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `update_type_quantity_on_insert` AFTER INSERT ON `items` FOR EACH ROW UPDATE `item type`
SET `item type`.`Num_products` = `item type`.`Num_products` + NEW.`Quantity`
WHERE NEW.`Item_type_id` = `item type`.`Item_type_id`
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `update_type_quantity_on_update` BEFORE UPDATE ON `items` FOR EACH ROW UPDATE `item type`
SET `item type`.`Num_products` = `item type`.`Num_products` - OLD.`Quantity`
WHERE `item type`.`Item_type_id` = OLD.`Item_type_id`
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `item type`
--

CREATE TABLE `item type` (
  `Item_type_id` varchar(10) NOT NULL,
  `Item_type_name` text NOT NULL,
  `Num_products` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `item type`
--

INSERT INTO `item type` (`Item_type_id`, `Item_type_name`, `Num_products`) VALUES
('GD', 'Đồ gia dụng', 24),
('LK', 'Linh kiện máy tính', 0),
('LT', 'Laptop', 3987),
('SP', 'Smartphone', 11);

-- --------------------------------------------------------

--
-- Table structure for table `post`
--

CREATE TABLE `post` (
  `id` varchar(7) DEFAULT NULL,
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_vietnamese_ci NOT NULL,
  `star_rate` double NOT NULL,
  `img_src` varchar(255) DEFAULT NULL,
  `date_posted` datetime NOT NULL,
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci;

--
-- Dumping data for table `post`
--

INSERT INTO `post` (`id`, `title`, `star_rate`, `img_src`, `date_posted`, `content`) VALUES
('POS0001', 'PlayStation 5 Black and White version of the PS5 coming out on sale.', 4.1, 'https://i.postimg.cc/8C1hsqDg/ps5-item2.webp', '2025-04-12 18:36:56', 'Chính sự phát triển của ngành công nghệ thông tin đã đánh dấu một giai đoạn phát triển mới cho con người. Cuộc sống trở nên hiện đại hơn, thông minh hơn và tiện ích hơn. Tuy nhiên, bên cạnh những tiện ích mà công nghệ mang lại, cũng tồn tại những tác động tiêu cực đối với cuộc sống của chúng ta. Vậy công nghệ ảnh hưởng thế nào đến cuộc sống con người? Hãy cùng chúng tôi khám phá điều này thông qua bài viết dưới đây.\nSự xuất hiện của khoa học công nghệ cùng với những phát minh khoa học tiên tiến đã hoàn toàn thay đổi bản chất cuộc sống của con người. Điện thoại thông minh, máy tính, điều hòa, robot, thanh toán bằng thẻ, và cả ô tô tự lái, máy bay tự lái,... đều là những sáng chế tiên tiến, thông minh của con người, đánh dấu một kỷ nguyên phát triển mới trong lịch sử nhân loại.\nSự xuất hiện của các thiết bị công nghệ tiên tiến đã thúc đẩy sự phát triển kinh tế và xã hội. Những thiết bị này giúp con người giải quyết công việc một cách nhanh chóng và hiệu quả, mà không cần phải tốn nhiều sức lao động.\nĐiện thoại không chỉ giúp chúng ta duy trì liên lạc với nhau, mà còn hỗ trợ giải trí, kinh doanh, và thanh toán. Điện thoại thông minh đã trở thành một phần không thể thiếu trong cuộc sống hàng ngày của chúng ta. Máy tính cũng đã giúp con người giải quyết công việc một cách nhanh chóng và hiệu quả. Hơn nữa, máy tính là công cụ giúp con người tìm kiếm thông tin hiệu quả, và không thể thiếu kết nối internet để hoàn thành nhiều nhiệm vụ. Điện thoại, máy tính và internet đều liên quan chặt chẽ và cùng nhau tạo nên cuộc sống hiện đại.\nNhững phát minh hiện đại như máy bay, ô tô tự lái, và cửa hàng tự động mà không cần người bán cũng mang lại nhiều lợi ích. Chúng đã đánh dấu một bước tiến mới trong sự phát triển của con người. Các thiết bị công nghệ tiên tiến, từ việc thay thế con người trong nhiều tác vụ, đến việc làm nhà bằng robot và hệ thống tự động trong gia đình, đều đã thay đổi cách chúng ta sống và làm việc.\nTuy nhiên, bên cạnh những lợi ích rõ ràng, không thể phủ nhận rằng còn tồn tại những hệ lụy của công nghệ. Công nghệ có thể làm cho chúng ta trở nên lười biếng hơn và đôi khi tạo ra sự ích kỷ và tình trạng căng thẳng. Chúng ta có thể thay thế công việc nhà bằng robot trong khi chỉ ngồi nghe nhạc hoặc xem phim. Khi điện thoại hoặc máy tính gặp sự cố, chúng ta có thể trở nên cáu kỉnh và tức giận.'),
('POS0002', 'PlayStation 5 Black and White version of the PS5 coming out on sale.', 4.2, 'https://i.postimg.cc/rpQ54QF0/ps5-item1.jpg', '2025-04-12 18:36:56', 'Chính sự phát triển của ngành công nghệ thông tin đã đánh dấu một giai đoạn phát triển mới cho con người. Cuộc sống trở nên hiện đại hơn, thông minh hơn và tiện ích hơn. Tuy nhiên, bên cạnh những tiện ích mà công nghệ mang lại, cũng tồn tại những tác động tiêu cực đối với cuộc sống của chúng ta. Vậy công nghệ ảnh hưởng thế nào đến cuộc sống con người? Hãy cùng chúng tôi khám phá điều này thông qua bài viết dưới đây.\nSự xuất hiện của khoa học công nghệ cùng với những phát minh khoa học tiên tiến đã hoàn toàn thay đổi bản chất cuộc sống của con người. Điện thoại thông minh, máy tính, điều hòa, robot, thanh toán bằng thẻ, và cả ô tô tự lái, máy bay tự lái,... đều là những sáng chế tiên tiến, thông minh của con người, đánh dấu một kỷ nguyên phát triển mới trong lịch sử nhân loại.\nSự xuất hiện của các thiết bị công nghệ tiên tiến đã thúc đẩy sự phát triển kinh tế và xã hội. Những thiết bị này giúp con người giải quyết công việc một cách nhanh chóng và hiệu quả, mà không cần phải tốn nhiều sức lao động.\nĐiện thoại không chỉ giúp chúng ta duy trì liên lạc với nhau, mà còn hỗ trợ giải trí, kinh doanh, và thanh toán. Điện thoại thông minh đã trở thành một phần không thể thiếu trong cuộc sống hàng ngày của chúng ta. Máy tính cũng đã giúp con người giải quyết công việc một cách nhanh chóng và hiệu quả. Hơn nữa, máy tính là công cụ giúp con người tìm kiếm thông tin hiệu quả, và không thể thiếu kết nối internet để hoàn thành nhiều nhiệm vụ. Điện thoại, máy tính và internet đều liên quan chặt chẽ và cùng nhau tạo nên cuộc sống hiện đại.\nNhững phát minh hiện đại như máy bay, ô tô tự lái, và cửa hàng tự động mà không cần người bán cũng mang lại nhiều lợi ích. Chúng đã đánh dấu một bước tiến mới trong sự phát triển của con người. Các thiết bị công nghệ tiên tiến, từ việc thay thế con người trong nhiều tác vụ, đến việc làm nhà bằng robot và hệ thống tự động trong gia đình, đều đã thay đổi cách chúng ta sống và làm việc.\nTuy nhiên, bên cạnh những lợi ích rõ ràng, không thể phủ nhận rằng còn tồn tại những hệ lụy của công nghệ. Công nghệ có thể làm cho chúng ta trở nên lười biếng hơn và đôi khi tạo ra sự ích kỷ và tình trạng căng thẳng. Chúng ta có thể thay thế công việc nhà bằng robot trong khi chỉ ngồi nghe nhạc hoặc xem phim. Khi điện thoại hoặc máy tính gặp sự cố, chúng ta có thể trở nên cáu kỉnh và tức giận.'),
('POS0003', 'PlayStation 5 Black and White version of the PS5 coming out on sale.', 4.3, 'https://i.postimg.cc/rpQ54QF0/ps5-item1.jpg', '2025-04-12 18:36:56', 'Chính sự phát triển của ngành công nghệ thông tin đã đánh dấu một giai đoạn phát triển mới cho con người. Cuộc sống trở nên hiện đại hơn, thông minh hơn và tiện ích hơn. Tuy nhiên, bên cạnh những tiện ích mà công nghệ mang lại, cũng tồn tại những tác động tiêu cực đối với cuộc sống của chúng ta. Vậy công nghệ ảnh hưởng thế nào đến cuộc sống con người? Hãy cùng chúng tôi khám phá điều này thông qua bài viết dưới đây.\nSự xuất hiện của khoa học công nghệ cùng với những phát minh khoa học tiên tiến đã hoàn toàn thay đổi bản chất cuộc sống của con người. Điện thoại thông minh, máy tính, điều hòa, robot, thanh toán bằng thẻ, và cả ô tô tự lái, máy bay tự lái,... đều là những sáng chế tiên tiến, thông minh của con người, đánh dấu một kỷ nguyên phát triển mới trong lịch sử nhân loại.\nSự xuất hiện của các thiết bị công nghệ tiên tiến đã thúc đẩy sự phát triển kinh tế và xã hội. Những thiết bị này giúp con người giải quyết công việc một cách nhanh chóng và hiệu quả, mà không cần phải tốn nhiều sức lao động.\nĐiện thoại không chỉ giúp chúng ta duy trì liên lạc với nhau, mà còn hỗ trợ giải trí, kinh doanh, và thanh toán. Điện thoại thông minh đã trở thành một phần không thể thiếu trong cuộc sống hàng ngày của chúng ta. Máy tính cũng đã giúp con người giải quyết công việc một cách nhanh chóng và hiệu quả. Hơn nữa, máy tính là công cụ giúp con người tìm kiếm thông tin hiệu quả, và không thể thiếu kết nối internet để hoàn thành nhiều nhiệm vụ. Điện thoại, máy tính và internet đều liên quan chặt chẽ và cùng nhau tạo nên cuộc sống hiện đại.\nNhững phát minh hiện đại như máy bay, ô tô tự lái, và cửa hàng tự động mà không cần người bán cũng mang lại nhiều lợi ích. Chúng đã đánh dấu một bước tiến mới trong sự phát triển của con người. Các thiết bị công nghệ tiên tiến, từ việc thay thế con người trong nhiều tác vụ, đến việc làm nhà bằng robot và hệ thống tự động trong gia đình, đều đã thay đổi cách chúng ta sống và làm việc.\nTuy nhiên, bên cạnh những lợi ích rõ ràng, không thể phủ nhận rằng còn tồn tại những hệ lụy của công nghệ. Công nghệ có thể làm cho chúng ta trở nên lười biếng hơn và đôi khi tạo ra sự ích kỷ và tình trạng căng thẳng. Chúng ta có thể thay thế công việc nhà bằng robot trong khi chỉ ngồi nghe nhạc hoặc xem phim. Khi điện thoại hoặc máy tính gặp sự cố, chúng ta có thể trở nên cáu kỉnh và tức giận.'),
('POS0004', 'PlayStation 5 Black and White version of the PS5 coming out on sale.', 4, 'https://i.postimg.cc/8C1hsqDg/ps5-item2.webp', '2025-04-12 18:36:56', 'Chính sự phát triển của ngành công nghệ thông tin đã đánh dấu một giai đoạn phát triển mới cho con người. Cuộc sống trở nên hiện đại hơn, thông minh hơn và tiện ích hơn. Tuy nhiên, bên cạnh những tiện ích mà công nghệ mang lại, cũng tồn tại những tác động tiêu cực đối với cuộc sống của chúng ta. Vậy công nghệ ảnh hưởng thế nào đến cuộc sống con người? Hãy cùng chúng tôi khám phá điều này thông qua bài viết dưới đây.\nSự xuất hiện của khoa học công nghệ cùng với những phát minh khoa học tiên tiến đã hoàn toàn thay đổi bản chất cuộc sống của con người. Điện thoại thông minh, máy tính, điều hòa, robot, thanh toán bằng thẻ, và cả ô tô tự lái, máy bay tự lái,... đều là những sáng chế tiên tiến, thông minh của con người, đánh dấu một kỷ nguyên phát triển mới trong lịch sử nhân loại.\nSự xuất hiện của các thiết bị công nghệ tiên tiến đã thúc đẩy sự phát triển kinh tế và xã hội. Những thiết bị này giúp con người giải quyết công việc một cách nhanh chóng và hiệu quả, mà không cần phải tốn nhiều sức lao động.\nĐiện thoại không chỉ giúp chúng ta duy trì liên lạc với nhau, mà còn hỗ trợ giải trí, kinh doanh, và thanh toán. Điện thoại thông minh đã trở thành một phần không thể thiếu trong cuộc sống hàng ngày của chúng ta. Máy tính cũng đã giúp con người giải quyết công việc một cách nhanh chóng và hiệu quả. Hơn nữa, máy tính là công cụ giúp con người tìm kiếm thông tin hiệu quả, và không thể thiếu kết nối internet để hoàn thành nhiều nhiệm vụ. Điện thoại, máy tính và internet đều liên quan chặt chẽ và cùng nhau tạo nên cuộc sống hiện đại.\nNhững phát minh hiện đại như máy bay, ô tô tự lái, và cửa hàng tự động mà không cần người bán cũng mang lại nhiều lợi ích. Chúng đã đánh dấu một bước tiến mới trong sự phát triển của con người. Các thiết bị công nghệ tiên tiến, từ việc thay thế con người trong nhiều tác vụ, đến việc làm nhà bằng robot và hệ thống tự động trong gia đình, đều đã thay đổi cách chúng ta sống và làm việc.\nTuy nhiên, bên cạnh những lợi ích rõ ràng, không thể phủ nhận rằng còn tồn tại những hệ lụy của công nghệ. Công nghệ có thể làm cho chúng ta trở nên lười biếng hơn và đôi khi tạo ra sự ích kỷ và tình trạng căng thẳng. Chúng ta có thể thay thế công việc nhà bằng robot trong khi chỉ ngồi nghe nhạc hoặc xem phim. Khi điện thoại hoặc máy tính gặp sự cố, chúng ta có thể trở nên cáu kỉnh và tức giận.'),
('POS0005', 'PlayStation 5 Black and White version of the PS5 coming out on sale.', 4.4, 'https://i.postimg.cc/rpQ54QF0/ps5-item1.jpg', '2025-04-12 18:36:56', 'Chính sự phát triển của ngành công nghệ thông tin đã đánh dấu một giai đoạn phát triển mới cho con người. Cuộc sống trở nên hiện đại hơn, thông minh hơn và tiện ích hơn. Tuy nhiên, bên cạnh những tiện ích mà công nghệ mang lại, cũng tồn tại những tác động tiêu cực đối với cuộc sống của chúng ta. Vậy công nghệ ảnh hưởng thế nào đến cuộc sống con người? Hãy cùng chúng tôi khám phá điều này thông qua bài viết dưới đây.\nSự xuất hiện của khoa học công nghệ cùng với những phát minh khoa học tiên tiến đã hoàn toàn thay đổi bản chất cuộc sống của con người. Điện thoại thông minh, máy tính, điều hòa, robot, thanh toán bằng thẻ, và cả ô tô tự lái, máy bay tự lái,... đều là những sáng chế tiên tiến, thông minh của con người, đánh dấu một kỷ nguyên phát triển mới trong lịch sử nhân loại.\nSự xuất hiện của các thiết bị công nghệ tiên tiến đã thúc đẩy sự phát triển kinh tế và xã hội. Những thiết bị này giúp con người giải quyết công việc một cách nhanh chóng và hiệu quả, mà không cần phải tốn nhiều sức lao động.\nĐiện thoại không chỉ giúp chúng ta duy trì liên lạc với nhau, mà còn hỗ trợ giải trí, kinh doanh, và thanh toán. Điện thoại thông minh đã trở thành một phần không thể thiếu trong cuộc sống hàng ngày của chúng ta. Máy tính cũng đã giúp con người giải quyết công việc một cách nhanh chóng và hiệu quả. Hơn nữa, máy tính là công cụ giúp con người tìm kiếm thông tin hiệu quả, và không thể thiếu kết nối internet để hoàn thành nhiều nhiệm vụ. Điện thoại, máy tính và internet đều liên quan chặt chẽ và cùng nhau tạo nên cuộc sống hiện đại.\nNhững phát minh hiện đại như máy bay, ô tô tự lái, và cửa hàng tự động mà không cần người bán cũng mang lại nhiều lợi ích. Chúng đã đánh dấu một bước tiến mới trong sự phát triển của con người. Các thiết bị công nghệ tiên tiến, từ việc thay thế con người trong nhiều tác vụ, đến việc làm nhà bằng robot và hệ thống tự động trong gia đình, đều đã thay đổi cách chúng ta sống và làm việc.\nTuy nhiên, bên cạnh những lợi ích rõ ràng, không thể phủ nhận rằng còn tồn tại những hệ lụy của công nghệ. Công nghệ có thể làm cho chúng ta trở nên lười biếng hơn và đôi khi tạo ra sự ích kỷ và tình trạng căng thẳng. Chúng ta có thể thay thế công việc nhà bằng robot trong khi chỉ ngồi nghe nhạc hoặc xem phim. Khi điện thoại hoặc máy tính gặp sự cố, chúng ta có thể trở nên cáu kỉnh và tức giận.'),
('POS0006', 'PlayStation 5 Black and White version of the PS5 coming out on sale.', 3.9, 'https://i.postimg.cc/rpQ54QF0/ps5-item1.jpg', '2025-04-12 18:36:56', 'Chính sự phát triển của ngành công nghệ thông tin đã đánh dấu một giai đoạn phát triển mới cho con người. Cuộc sống trở nên hiện đại hơn, thông minh hơn và tiện ích hơn. Tuy nhiên, bên cạnh những tiện ích mà công nghệ mang lại, cũng tồn tại những tác động tiêu cực đối với cuộc sống của chúng ta. Vậy công nghệ ảnh hưởng thế nào đến cuộc sống con người? Hãy cùng chúng tôi khám phá điều này thông qua bài viết dưới đây.\nSự xuất hiện của khoa học công nghệ cùng với những phát minh khoa học tiên tiến đã hoàn toàn thay đổi bản chất cuộc sống của con người. Điện thoại thông minh, máy tính, điều hòa, robot, thanh toán bằng thẻ, và cả ô tô tự lái, máy bay tự lái,... đều là những sáng chế tiên tiến, thông minh của con người, đánh dấu một kỷ nguyên phát triển mới trong lịch sử nhân loại.\nSự xuất hiện của các thiết bị công nghệ tiên tiến đã thúc đẩy sự phát triển kinh tế và xã hội. Những thiết bị này giúp con người giải quyết công việc một cách nhanh chóng và hiệu quả, mà không cần phải tốn nhiều sức lao động.\nĐiện thoại không chỉ giúp chúng ta duy trì liên lạc với nhau, mà còn hỗ trợ giải trí, kinh doanh, và thanh toán. Điện thoại thông minh đã trở thành một phần không thể thiếu trong cuộc sống hàng ngày của chúng ta. Máy tính cũng đã giúp con người giải quyết công việc một cách nhanh chóng và hiệu quả. Hơn nữa, máy tính là công cụ giúp con người tìm kiếm thông tin hiệu quả, và không thể thiếu kết nối internet để hoàn thành nhiều nhiệm vụ. Điện thoại, máy tính và internet đều liên quan chặt chẽ và cùng nhau tạo nên cuộc sống hiện đại.\nNhững phát minh hiện đại như máy bay, ô tô tự lái, và cửa hàng tự động mà không cần người bán cũng mang lại nhiều lợi ích. Chúng đã đánh dấu một bước tiến mới trong sự phát triển của con người. Các thiết bị công nghệ tiên tiến, từ việc thay thế con người trong nhiều tác vụ, đến việc làm nhà bằng robot và hệ thống tự động trong gia đình, đều đã thay đổi cách chúng ta sống và làm việc.\nTuy nhiên, bên cạnh những lợi ích rõ ràng, không thể phủ nhận rằng còn tồn tại những hệ lụy của công nghệ. Công nghệ có thể làm cho chúng ta trở nên lười biếng hơn và đôi khi tạo ra sự ích kỷ và tình trạng căng thẳng. Chúng ta có thể thay thế công việc nhà bằng robot trong khi chỉ ngồi nghe nhạc hoặc xem phim. Khi điện thoại hoặc máy tính gặp sự cố, chúng ta có thể trở nên cáu kỉnh và tức giận.'),
('POS0007', 'PlayStation 5 Black and White version of the PS5 coming out on sale.', 4.1, 'https://i.postimg.cc/rpQ54QF0/ps5-item1.jpg', '2025-04-12 18:36:56', 'Chính sự phát triển của ngành công nghệ thông tin đã đánh dấu một giai đoạn phát triển mới cho con người. Cuộc sống trở nên hiện đại hơn, thông minh hơn và tiện ích hơn. Tuy nhiên, bên cạnh những tiện ích mà công nghệ mang lại, cũng tồn tại những tác động tiêu cực đối với cuộc sống của chúng ta. Vậy công nghệ ảnh hưởng thế nào đến cuộc sống con người? Hãy cùng chúng tôi khám phá điều này thông qua bài viết dưới đây.\nSự xuất hiện của khoa học công nghệ cùng với những phát minh khoa học tiên tiến đã hoàn toàn thay đổi bản chất cuộc sống của con người. Điện thoại thông minh, máy tính, điều hòa, robot, thanh toán bằng thẻ, và cả ô tô tự lái, máy bay tự lái,... đều là những sáng chế tiên tiến, thông minh của con người, đánh dấu một kỷ nguyên phát triển mới trong lịch sử nhân loại.\nSự xuất hiện của các thiết bị công nghệ tiên tiến đã thúc đẩy sự phát triển kinh tế và xã hội. Những thiết bị này giúp con người giải quyết công việc một cách nhanh chóng và hiệu quả, mà không cần phải tốn nhiều sức lao động.\nĐiện thoại không chỉ giúp chúng ta duy trì liên lạc với nhau, mà còn hỗ trợ giải trí, kinh doanh, và thanh toán. Điện thoại thông minh đã trở thành một phần không thể thiếu trong cuộc sống hàng ngày của chúng ta. Máy tính cũng đã giúp con người giải quyết công việc một cách nhanh chóng và hiệu quả. Hơn nữa, máy tính là công cụ giúp con người tìm kiếm thông tin hiệu quả, và không thể thiếu kết nối internet để hoàn thành nhiều nhiệm vụ. Điện thoại, máy tính và internet đều liên quan chặt chẽ và cùng nhau tạo nên cuộc sống hiện đại.\nNhững phát minh hiện đại như máy bay, ô tô tự lái, và cửa hàng tự động mà không cần người bán cũng mang lại nhiều lợi ích. Chúng đã đánh dấu một bước tiến mới trong sự phát triển của con người. Các thiết bị công nghệ tiên tiến, từ việc thay thế con người trong nhiều tác vụ, đến việc làm nhà bằng robot và hệ thống tự động trong gia đình, đều đã thay đổi cách chúng ta sống và làm việc.\nTuy nhiên, bên cạnh những lợi ích rõ ràng, không thể phủ nhận rằng còn tồn tại những hệ lụy của công nghệ. Công nghệ có thể làm cho chúng ta trở nên lười biếng hơn và đôi khi tạo ra sự ích kỷ và tình trạng căng thẳng. Chúng ta có thể thay thế công việc nhà bằng robot trong khi chỉ ngồi nghe nhạc hoặc xem phim. Khi điện thoại hoặc máy tính gặp sự cố, chúng ta có thể trở nên cáu kỉnh và tức giận.'),
('POS0008', 'PlayStation 5 Black and White version of the PS5 coming out on sale.', 4.1, 'https://i.postimg.cc/8C1hsqDg/ps5-item2.webp', '2025-04-12 18:36:56', 'Chính sự phát triển của ngành công nghệ thông tin đã đánh dấu một giai đoạn phát triển mới cho con người. Cuộc sống trở nên hiện đại hơn, thông minh hơn và tiện ích hơn. Tuy nhiên, bên cạnh những tiện ích mà công nghệ mang lại, cũng tồn tại những tác động tiêu cực đối với cuộc sống của chúng ta. Vậy công nghệ ảnh hưởng thế nào đến cuộc sống con người? Hãy cùng chúng tôi khám phá điều này thông qua bài viết dưới đây.\nSự xuất hiện của khoa học công nghệ cùng với những phát minh khoa học tiên tiến đã hoàn toàn thay đổi bản chất cuộc sống của con người. Điện thoại thông minh, máy tính, điều hòa, robot, thanh toán bằng thẻ, và cả ô tô tự lái, máy bay tự lái,... đều là những sáng chế tiên tiến, thông minh của con người, đánh dấu một kỷ nguyên phát triển mới trong lịch sử nhân loại.\nSự xuất hiện của các thiết bị công nghệ tiên tiến đã thúc đẩy sự phát triển kinh tế và xã hội. Những thiết bị này giúp con người giải quyết công việc một cách nhanh chóng và hiệu quả, mà không cần phải tốn nhiều sức lao động.\nĐiện thoại không chỉ giúp chúng ta duy trì liên lạc với nhau, mà còn hỗ trợ giải trí, kinh doanh, và thanh toán. Điện thoại thông minh đã trở thành một phần không thể thiếu trong cuộc sống hàng ngày của chúng ta. Máy tính cũng đã giúp con người giải quyết công việc một cách nhanh chóng và hiệu quả. Hơn nữa, máy tính là công cụ giúp con người tìm kiếm thông tin hiệu quả, và không thể thiếu kết nối internet để hoàn thành nhiều nhiệm vụ. Điện thoại, máy tính và internet đều liên quan chặt chẽ và cùng nhau tạo nên cuộc sống hiện đại.\nNhững phát minh hiện đại như máy bay, ô tô tự lái, và cửa hàng tự động mà không cần người bán cũng mang lại nhiều lợi ích. Chúng đã đánh dấu một bước tiến mới trong sự phát triển của con người. Các thiết bị công nghệ tiên tiến, từ việc thay thế con người trong nhiều tác vụ, đến việc làm nhà bằng robot và hệ thống tự động trong gia đình, đều đã thay đổi cách chúng ta sống và làm việc.\nTuy nhiên, bên cạnh những lợi ích rõ ràng, không thể phủ nhận rằng còn tồn tại những hệ lụy của công nghệ. Công nghệ có thể làm cho chúng ta trở nên lười biếng hơn và đôi khi tạo ra sự ích kỷ và tình trạng căng thẳng. Chúng ta có thể thay thế công việc nhà bằng robot trong khi chỉ ngồi nghe nhạc hoặc xem phim. Khi điện thoại hoặc máy tính gặp sự cố, chúng ta có thể trở nên cáu kỉnh và tức giận.'),
('POS0009', 'PlayStation 5 Black and White version of the PS5 coming out on sale.', 4.5, 'https://i.postimg.cc/rpQ54QF0/ps5-item1.jpg', '2025-04-12 18:36:56', 'Chính sự phát triển của ngành công nghệ thông tin đã đánh dấu một giai đoạn phát triển mới cho con người. Cuộc sống trở nên hiện đại hơn, thông minh hơn và tiện ích hơn. Tuy nhiên, bên cạnh những tiện ích mà công nghệ mang lại, cũng tồn tại những tác động tiêu cực đối với cuộc sống của chúng ta. Vậy công nghệ ảnh hưởng thế nào đến cuộc sống con người? Hãy cùng chúng tôi khám phá điều này thông qua bài viết dưới đây.\nSự xuất hiện của khoa học công nghệ cùng với những phát minh khoa học tiên tiến đã hoàn toàn thay đổi bản chất cuộc sống của con người. Điện thoại thông minh, máy tính, điều hòa, robot, thanh toán bằng thẻ, và cả ô tô tự lái, máy bay tự lái,... đều là những sáng chế tiên tiến, thông minh của con người, đánh dấu một kỷ nguyên phát triển mới trong lịch sử nhân loại.\nSự xuất hiện của các thiết bị công nghệ tiên tiến đã thúc đẩy sự phát triển kinh tế và xã hội. Những thiết bị này giúp con người giải quyết công việc một cách nhanh chóng và hiệu quả, mà không cần phải tốn nhiều sức lao động.\nĐiện thoại không chỉ giúp chúng ta duy trì liên lạc với nhau, mà còn hỗ trợ giải trí, kinh doanh, và thanh toán. Điện thoại thông minh đã trở thành một phần không thể thiếu trong cuộc sống hàng ngày của chúng ta. Máy tính cũng đã giúp con người giải quyết công việc một cách nhanh chóng và hiệu quả. Hơn nữa, máy tính là công cụ giúp con người tìm kiếm thông tin hiệu quả, và không thể thiếu kết nối internet để hoàn thành nhiều nhiệm vụ. Điện thoại, máy tính và internet đều liên quan chặt chẽ và cùng nhau tạo nên cuộc sống hiện đại.\nNhững phát minh hiện đại như máy bay, ô tô tự lái, và cửa hàng tự động mà không cần người bán cũng mang lại nhiều lợi ích. Chúng đã đánh dấu một bước tiến mới trong sự phát triển của con người. Các thiết bị công nghệ tiên tiến, từ việc thay thế con người trong nhiều tác vụ, đến việc làm nhà bằng robot và hệ thống tự động trong gia đình, đều đã thay đổi cách chúng ta sống và làm việc.\nTuy nhiên, bên cạnh những lợi ích rõ ràng, không thể phủ nhận rằng còn tồn tại những hệ lụy của công nghệ. Công nghệ có thể làm cho chúng ta trở nên lười biếng hơn và đôi khi tạo ra sự ích kỷ và tình trạng căng thẳng. Chúng ta có thể thay thế công việc nhà bằng robot trong khi chỉ ngồi nghe nhạc hoặc xem phim. Khi điện thoại hoặc máy tính gặp sự cố, chúng ta có thể trở nên cáu kỉnh và tức giận.'),
('POS0010', 'PlayStation 5 Black and White version of the PS5 coming out on sale.', 4.7, 'https://i.postimg.cc/rpQ54QF0/ps5-item1.jpg', '2025-04-12 18:36:56', 'Chính sự phát triển của ngành công nghệ thông tin đã đánh dấu một giai đoạn phát triển mới cho con người. Cuộc sống trở nên hiện đại hơn, thông minh hơn và tiện ích hơn. Tuy nhiên, bên cạnh những tiện ích mà công nghệ mang lại, cũng tồn tại những tác động tiêu cực đối với cuộc sống của chúng ta. Vậy công nghệ ảnh hưởng thế nào đến cuộc sống con người? Hãy cùng chúng tôi khám phá điều này thông qua bài viết dưới đây.\nSự xuất hiện của khoa học công nghệ cùng với những phát minh khoa học tiên tiến đã hoàn toàn thay đổi bản chất cuộc sống của con người. Điện thoại thông minh, máy tính, điều hòa, robot, thanh toán bằng thẻ, và cả ô tô tự lái, máy bay tự lái,... đều là những sáng chế tiên tiến, thông minh của con người, đánh dấu một kỷ nguyên phát triển mới trong lịch sử nhân loại.\nSự xuất hiện của các thiết bị công nghệ tiên tiến đã thúc đẩy sự phát triển kinh tế và xã hội. Những thiết bị này giúp con người giải quyết công việc một cách nhanh chóng và hiệu quả, mà không cần phải tốn nhiều sức lao động.\nĐiện thoại không chỉ giúp chúng ta duy trì liên lạc với nhau, mà còn hỗ trợ giải trí, kinh doanh, và thanh toán. Điện thoại thông minh đã trở thành một phần không thể thiếu trong cuộc sống hàng ngày của chúng ta. Máy tính cũng đã giúp con người giải quyết công việc một cách nhanh chóng và hiệu quả. Hơn nữa, máy tính là công cụ giúp con người tìm kiếm thông tin hiệu quả, và không thể thiếu kết nối internet để hoàn thành nhiều nhiệm vụ. Điện thoại, máy tính và internet đều liên quan chặt chẽ và cùng nhau tạo nên cuộc sống hiện đại.\nNhững phát minh hiện đại như máy bay, ô tô tự lái, và cửa hàng tự động mà không cần người bán cũng mang lại nhiều lợi ích. Chúng đã đánh dấu một bước tiến mới trong sự phát triển của con người. Các thiết bị công nghệ tiên tiến, từ việc thay thế con người trong nhiều tác vụ, đến việc làm nhà bằng robot và hệ thống tự động trong gia đình, đều đã thay đổi cách chúng ta sống và làm việc.\nTuy nhiên, bên cạnh những lợi ích rõ ràng, không thể phủ nhận rằng còn tồn tại những hệ lụy của công nghệ. Công nghệ có thể làm cho chúng ta trở nên lười biếng hơn và đôi khi tạo ra sự ích kỷ và tình trạng căng thẳng. Chúng ta có thể thay thế công việc nhà bằng robot trong khi chỉ ngồi nghe nhạc hoặc xem phim. Khi điện thoại hoặc máy tính gặp sự cố, chúng ta có thể trở nên cáu kỉnh và tức giận.'),
('POS0011', 'PlayStation 5 Black and White version of the PS5 coming out on sale.', 4.1, 'https://i.postimg.cc/8C1hsqDg/ps5-item2.webp', '2025-04-12 18:36:56', 'Chính sự phát triển của ngành công nghệ thông tin đã đánh dấu một giai đoạn phát triển mới cho con người. Cuộc sống trở nên hiện đại hơn, thông minh hơn và tiện ích hơn. Tuy nhiên, bên cạnh những tiện ích mà công nghệ mang lại, cũng tồn tại những tác động tiêu cực đối với cuộc sống của chúng ta. Vậy công nghệ ảnh hưởng thế nào đến cuộc sống con người? Hãy cùng chúng tôi khám phá điều này thông qua bài viết dưới đây.\nSự xuất hiện của khoa học công nghệ cùng với những phát minh khoa học tiên tiến đã hoàn toàn thay đổi bản chất cuộc sống của con người. Điện thoại thông minh, máy tính, điều hòa, robot, thanh toán bằng thẻ, và cả ô tô tự lái, máy bay tự lái,... đều là những sáng chế tiên tiến, thông minh của con người, đánh dấu một kỷ nguyên phát triển mới trong lịch sử nhân loại.\nSự xuất hiện của các thiết bị công nghệ tiên tiến đã thúc đẩy sự phát triển kinh tế và xã hội. Những thiết bị này giúp con người giải quyết công việc một cách nhanh chóng và hiệu quả, mà không cần phải tốn nhiều sức lao động.\nĐiện thoại không chỉ giúp chúng ta duy trì liên lạc với nhau, mà còn hỗ trợ giải trí, kinh doanh, và thanh toán. Điện thoại thông minh đã trở thành một phần không thể thiếu trong cuộc sống hàng ngày của chúng ta. Máy tính cũng đã giúp con người giải quyết công việc một cách nhanh chóng và hiệu quả. Hơn nữa, máy tính là công cụ giúp con người tìm kiếm thông tin hiệu quả, và không thể thiếu kết nối internet để hoàn thành nhiều nhiệm vụ. Điện thoại, máy tính và internet đều liên quan chặt chẽ và cùng nhau tạo nên cuộc sống hiện đại.\nNhững phát minh hiện đại như máy bay, ô tô tự lái, và cửa hàng tự động mà không cần người bán cũng mang lại nhiều lợi ích. Chúng đã đánh dấu một bước tiến mới trong sự phát triển của con người. Các thiết bị công nghệ tiên tiến, từ việc thay thế con người trong nhiều tác vụ, đến việc làm nhà bằng robot và hệ thống tự động trong gia đình, đều đã thay đổi cách chúng ta sống và làm việc.\nTuy nhiên, bên cạnh những lợi ích rõ ràng, không thể phủ nhận rằng còn tồn tại những hệ lụy của công nghệ. Công nghệ có thể làm cho chúng ta trở nên lười biếng hơn và đôi khi tạo ra sự ích kỷ và tình trạng căng thẳng. Chúng ta có thể thay thế công việc nhà bằng robot trong khi chỉ ngồi nghe nhạc hoặc xem phim. Khi điện thoại hoặc máy tính gặp sự cố, chúng ta có thể trở nên cáu kỉnh và tức giận.'),
('POS0012', 'PlayStation 5 Black and White version of the PS5 coming out on sale.', 4, 'https://i.postimg.cc/rpQ54QF0/ps5-item1.jpg', '2025-04-12 18:36:56', 'Chính sự phát triển của ngành công nghệ thông tin đã đánh dấu một giai đoạn phát triển mới cho con người. Cuộc sống trở nên hiện đại hơn, thông minh hơn và tiện ích hơn. Tuy nhiên, bên cạnh những tiện ích mà công nghệ mang lại, cũng tồn tại những tác động tiêu cực đối với cuộc sống của chúng ta. Vậy công nghệ ảnh hưởng thế nào đến cuộc sống con người? Hãy cùng chúng tôi khám phá điều này thông qua bài viết dưới đây.\nSự xuất hiện của khoa học công nghệ cùng với những phát minh khoa học tiên tiến đã hoàn toàn thay đổi bản chất cuộc sống của con người. Điện thoại thông minh, máy tính, điều hòa, robot, thanh toán bằng thẻ, và cả ô tô tự lái, máy bay tự lái,... đều là những sáng chế tiên tiến, thông minh của con người, đánh dấu một kỷ nguyên phát triển mới trong lịch sử nhân loại.\nSự xuất hiện của các thiết bị công nghệ tiên tiến đã thúc đẩy sự phát triển kinh tế và xã hội. Những thiết bị này giúp con người giải quyết công việc một cách nhanh chóng và hiệu quả, mà không cần phải tốn nhiều sức lao động.\nĐiện thoại không chỉ giúp chúng ta duy trì liên lạc với nhau, mà còn hỗ trợ giải trí, kinh doanh, và thanh toán. Điện thoại thông minh đã trở thành một phần không thể thiếu trong cuộc sống hàng ngày của chúng ta. Máy tính cũng đã giúp con người giải quyết công việc một cách nhanh chóng và hiệu quả. Hơn nữa, máy tính là công cụ giúp con người tìm kiếm thông tin hiệu quả, và không thể thiếu kết nối internet để hoàn thành nhiều nhiệm vụ. Điện thoại, máy tính và internet đều liên quan chặt chẽ và cùng nhau tạo nên cuộc sống hiện đại.\nNhững phát minh hiện đại như máy bay, ô tô tự lái, và cửa hàng tự động mà không cần người bán cũng mang lại nhiều lợi ích. Chúng đã đánh dấu một bước tiến mới trong sự phát triển của con người. Các thiết bị công nghệ tiên tiến, từ việc thay thế con người trong nhiều tác vụ, đến việc làm nhà bằng robot và hệ thống tự động trong gia đình, đều đã thay đổi cách chúng ta sống và làm việc.\nTuy nhiên, bên cạnh những lợi ích rõ ràng, không thể phủ nhận rằng còn tồn tại những hệ lụy của công nghệ. Công nghệ có thể làm cho chúng ta trở nên lười biếng hơn và đôi khi tạo ra sự ích kỷ và tình trạng căng thẳng. Chúng ta có thể thay thế công việc nhà bằng robot trong khi chỉ ngồi nghe nhạc hoặc xem phim. Khi điện thoại hoặc máy tính gặp sự cố, chúng ta có thể trở nên cáu kỉnh và tức giận.'),
('POS0013', 'PlayStation 5 Black and White version of the PS5 coming out on sale.', 4, 'https://i.postimg.cc/8C1hsqDg/ps5-item2.webp', '2025-04-12 18:36:56', 'Chính sự phát triển của ngành công nghệ thông tin đã đánh dấu một giai đoạn phát triển mới cho con người. Cuộc sống trở nên hiện đại hơn, thông minh hơn và tiện ích hơn. Tuy nhiên, bên cạnh những tiện ích mà công nghệ mang lại, cũng tồn tại những tác động tiêu cực đối với cuộc sống của chúng ta. Vậy công nghệ ảnh hưởng thế nào đến cuộc sống con người? Hãy cùng chúng tôi khám phá điều này thông qua bài viết dưới đây.\nSự xuất hiện của khoa học công nghệ cùng với những phát minh khoa học tiên tiến đã hoàn toàn thay đổi bản chất cuộc sống của con người. Điện thoại thông minh, máy tính, điều hòa, robot, thanh toán bằng thẻ, và cả ô tô tự lái, máy bay tự lái,... đều là những sáng chế tiên tiến, thông minh của con người, đánh dấu một kỷ nguyên phát triển mới trong lịch sử nhân loại.\nSự xuất hiện của các thiết bị công nghệ tiên tiến đã thúc đẩy sự phát triển kinh tế và xã hội. Những thiết bị này giúp con người giải quyết công việc một cách nhanh chóng và hiệu quả, mà không cần phải tốn nhiều sức lao động.\nĐiện thoại không chỉ giúp chúng ta duy trì liên lạc với nhau, mà còn hỗ trợ giải trí, kinh doanh, và thanh toán. Điện thoại thông minh đã trở thành một phần không thể thiếu trong cuộc sống hàng ngày của chúng ta. Máy tính cũng đã giúp con người giải quyết công việc một cách nhanh chóng và hiệu quả. Hơn nữa, máy tính là công cụ giúp con người tìm kiếm thông tin hiệu quả, và không thể thiếu kết nối internet để hoàn thành nhiều nhiệm vụ. Điện thoại, máy tính và internet đều liên quan chặt chẽ và cùng nhau tạo nên cuộc sống hiện đại.\nNhững phát minh hiện đại như máy bay, ô tô tự lái, và cửa hàng tự động mà không cần người bán cũng mang lại nhiều lợi ích. Chúng đã đánh dấu một bước tiến mới trong sự phát triển của con người. Các thiết bị công nghệ tiên tiến, từ việc thay thế con người trong nhiều tác vụ, đến việc làm nhà bằng robot và hệ thống tự động trong gia đình, đều đã thay đổi cách chúng ta sống và làm việc.\nTuy nhiên, bên cạnh những lợi ích rõ ràng, không thể phủ nhận rằng còn tồn tại những hệ lụy của công nghệ. Công nghệ có thể làm cho chúng ta trở nên lười biếng hơn và đôi khi tạo ra sự ích kỷ và tình trạng căng thẳng. Chúng ta có thể thay thế công việc nhà bằng robot trong khi chỉ ngồi nghe nhạc hoặc xem phim. Khi điện thoại hoặc máy tính gặp sự cố, chúng ta có thể trở nên cáu kỉnh và tức giận.'),
('POS0014', 'PlayStation 5 Black and White version of the PS5 coming out on sale.', 4.6, 'https://i.postimg.cc/rpQ54QF0/ps5-item1.jpg', '2025-04-12 18:36:56', 'Chính sự phát triển của ngành công nghệ thông tin đã đánh dấu một giai đoạn phát triển mới cho con người. Cuộc sống trở nên hiện đại hơn, thông minh hơn và tiện ích hơn. Tuy nhiên, bên cạnh những tiện ích mà công nghệ mang lại, cũng tồn tại những tác động tiêu cực đối với cuộc sống của chúng ta. Vậy công nghệ ảnh hưởng thế nào đến cuộc sống con người? Hãy cùng chúng tôi khám phá điều này thông qua bài viết dưới đây.\nSự xuất hiện của khoa học công nghệ cùng với những phát minh khoa học tiên tiến đã hoàn toàn thay đổi bản chất cuộc sống của con người. Điện thoại thông minh, máy tính, điều hòa, robot, thanh toán bằng thẻ, và cả ô tô tự lái, máy bay tự lái,... đều là những sáng chế tiên tiến, thông minh của con người, đánh dấu một kỷ nguyên phát triển mới trong lịch sử nhân loại.\nSự xuất hiện của các thiết bị công nghệ tiên tiến đã thúc đẩy sự phát triển kinh tế và xã hội. Những thiết bị này giúp con người giải quyết công việc một cách nhanh chóng và hiệu quả, mà không cần phải tốn nhiều sức lao động.\nĐiện thoại không chỉ giúp chúng ta duy trì liên lạc với nhau, mà còn hỗ trợ giải trí, kinh doanh, và thanh toán. Điện thoại thông minh đã trở thành một phần không thể thiếu trong cuộc sống hàng ngày của chúng ta. Máy tính cũng đã giúp con người giải quyết công việc một cách nhanh chóng và hiệu quả. Hơn nữa, máy tính là công cụ giúp con người tìm kiếm thông tin hiệu quả, và không thể thiếu kết nối internet để hoàn thành nhiều nhiệm vụ. Điện thoại, máy tính và internet đều liên quan chặt chẽ và cùng nhau tạo nên cuộc sống hiện đại.\nNhững phát minh hiện đại như máy bay, ô tô tự lái, và cửa hàng tự động mà không cần người bán cũng mang lại nhiều lợi ích. Chúng đã đánh dấu một bước tiến mới trong sự phát triển của con người. Các thiết bị công nghệ tiên tiến, từ việc thay thế con người trong nhiều tác vụ, đến việc làm nhà bằng robot và hệ thống tự động trong gia đình, đều đã thay đổi cách chúng ta sống và làm việc.\nTuy nhiên, bên cạnh những lợi ích rõ ràng, không thể phủ nhận rằng còn tồn tại những hệ lụy của công nghệ. Công nghệ có thể làm cho chúng ta trở nên lười biếng hơn và đôi khi tạo ra sự ích kỷ và tình trạng căng thẳng. Chúng ta có thể thay thế công việc nhà bằng robot trong khi chỉ ngồi nghe nhạc hoặc xem phim. Khi điện thoại hoặc máy tính gặp sự cố, chúng ta có thể trở nên cáu kỉnh và tức giận.'),
('POS0015', 'PlayStation 5 Black and White version of the PS5 coming out on sale.', 4.4, 'https://i.postimg.cc/rpQ54QF0/ps5-item1.jpg', '2025-04-12 18:36:56', 'Chính sự phát triển của ngành công nghệ thông tin đã đánh dấu một giai đoạn phát triển mới cho con người. Cuộc sống trở nên hiện đại hơn, thông minh hơn và tiện ích hơn. Tuy nhiên, bên cạnh những tiện ích mà công nghệ mang lại, cũng tồn tại những tác động tiêu cực đối với cuộc sống của chúng ta. Vậy công nghệ ảnh hưởng thế nào đến cuộc sống con người? Hãy cùng chúng tôi khám phá điều này thông qua bài viết dưới đây.\nSự xuất hiện của khoa học công nghệ cùng với những phát minh khoa học tiên tiến đã hoàn toàn thay đổi bản chất cuộc sống của con người. Điện thoại thông minh, máy tính, điều hòa, robot, thanh toán bằng thẻ, và cả ô tô tự lái, máy bay tự lái,... đều là những sáng chế tiên tiến, thông minh của con người, đánh dấu một kỷ nguyên phát triển mới trong lịch sử nhân loại.\nSự xuất hiện của các thiết bị công nghệ tiên tiến đã thúc đẩy sự phát triển kinh tế và xã hội. Những thiết bị này giúp con người giải quyết công việc một cách nhanh chóng và hiệu quả, mà không cần phải tốn nhiều sức lao động.\nĐiện thoại không chỉ giúp chúng ta duy trì liên lạc với nhau, mà còn hỗ trợ giải trí, kinh doanh, và thanh toán. Điện thoại thông minh đã trở thành một phần không thể thiếu trong cuộc sống hàng ngày của chúng ta. Máy tính cũng đã giúp con người giải quyết công việc một cách nhanh chóng và hiệu quả. Hơn nữa, máy tính là công cụ giúp con người tìm kiếm thông tin hiệu quả, và không thể thiếu kết nối internet để hoàn thành nhiều nhiệm vụ. Điện thoại, máy tính và internet đều liên quan chặt chẽ và cùng nhau tạo nên cuộc sống hiện đại.\nNhững phát minh hiện đại như máy bay, ô tô tự lái, và cửa hàng tự động mà không cần người bán cũng mang lại nhiều lợi ích. Chúng đã đánh dấu một bước tiến mới trong sự phát triển của con người. Các thiết bị công nghệ tiên tiến, từ việc thay thế con người trong nhiều tác vụ, đến việc làm nhà bằng robot và hệ thống tự động trong gia đình, đều đã thay đổi cách chúng ta sống và làm việc.\nTuy nhiên, bên cạnh những lợi ích rõ ràng, không thể phủ nhận rằng còn tồn tại những hệ lụy của công nghệ. Công nghệ có thể làm cho chúng ta trở nên lười biếng hơn và đôi khi tạo ra sự ích kỷ và tình trạng căng thẳng. Chúng ta có thể thay thế công việc nhà bằng robot trong khi chỉ ngồi nghe nhạc hoặc xem phim. Khi điện thoại hoặc máy tính gặp sự cố, chúng ta có thể trở nên cáu kỉnh và tức giận.'),
('POS0016', 'Chỉnh sửa lại title bằng update post', 0, 'https://i.postimg.cc/8C1hsqDg/ps5-item2.webp', '2025-05-05 09:46:08', 'something');

--
-- Triggers `post`
--
DELIMITER $$
CREATE TRIGGER `postGenerateNewId` BEFORE INSERT ON `post` FOR EACH ROW BEGIN
    DECLARE next_id INT DEFAULT 0;
    DECLARE formatted_id VARCHAR(7);

    -- 1. Find the highest existing numeric part of COM IDs
    SELECT
        IFNULL(MAX(CAST(SUBSTRING(id, 4) AS UNSIGNED)), 0) INTO next_id
    FROM
        post
    WHERE
        id LIKE 'POS%';

    -- 2. Increment the numeric part
    SET next_id = next_id + 1;

    -- 3. Format the ID
    SET formatted_id = CONCAT('POS', LPAD(next_id, 4, '0'));

    -- 4. Assign the new ID to the 'id' column of the new row
    SET NEW.id = formatted_id;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` varchar(7) NOT NULL,
  `username` varchar(100) NOT NULL,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `citizen_id` varchar(12) NOT NULL,
  `phone_num` varchar(12) NOT NULL,
  `address` varchar(255) NOT NULL,
  `birth_date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `username`, `first_name`, `last_name`, `citizen_id`, `phone_num`, `address`, `birth_date`) VALUES
('CUS0001', 'customer01', 'A', 'Nguyen Van', '079097079907', '0901020304', '1 Huynh Tinh Cua, P.19, Q.Binh Thanh', '2004-12-01'),
('CUS0002', 'buyer22', 'B', 'Tran Thi', '081102012345', '0987654321', '5 Nguyen Hue, P.Ben Nghe, Q.1', '2002-05-15'),
('CUS0003', 'onlineuser', 'C', 'Le Minh', '093088056789', '0333444555', '10 Vo Van Tan, P.6, Q.3', '1999-11-20'),
('CUS0004', 'happyclient', 'D', 'Pham Hoang', '077105098765', '0777888999', '2 Bach Dang, P.2, Q.Tan Binh', '2005-03-10'),
('CUS0005', 'shopaholic', 'E', 'Hoang Thu', '086099023456', '0912345678', '15 Le Loi, P.Ben Thanh, Q.1', '2001-08-25'),
('CUS0006', 'digitalguy', 'F', 'Vu Duc', '095096067890', '0369874123', '8 Dien Bien Phu, P.11, Q.10', '2003-01-05'),
('CUS0007', 'fashionista', 'G', 'Do Thuy', '089101034567', '0935789123', '3 Hai Ba Trung, P.Da Kao, Q.1', '2000-07-18'),
('CUS0008', 'techlover', 'H', 'Bui Anh', '091094045678', '0791234567', '20 Truong Chinh, P.15, Q.Tan Binh', '1998-09-30'),
('CUS0009', 'bookworm', 'I', 'Cao Thanh', '075103089012', '0963214789', '7 Nguyen Trai, P.Ben Thanh, Q.1', '2006-04-22'),
('CUS0010', 'traveler', 'K', 'Ly Diem', '083100090123', '0398765432', '12 Phan Xich Long, P.3, Q.Phu Nhuan', '2002-12-10'),
('CUS0011', 'jasmine', 'Z', 'Võ Thị', '019348374293', '0193872414', '3 Bạch Đằng, phường 9, quận Phú Nhuận, TP. HCM', '2003-06-10');

--
-- Triggers `user`
--
DELIMITER $$
CREATE TRIGGER `userGenerateNewId` BEFORE INSERT ON `user` FOR EACH ROW BEGIN
    DECLARE next_id INT DEFAULT 0;
    DECLARE formatted_id VARCHAR(7);

    -- 1. Find the highest existing numeric part of COM IDs
    SELECT
        IFNULL(MAX(CAST(SUBSTRING(id, 4) AS UNSIGNED)), 0) INTO next_id
    FROM
        user
    WHERE
        id LIKE 'CUS%';

    -- 2. Increment the numeric part
    SET next_id = next_id + 1;

    -- 3. Format the ID
    SET formatted_id = CONCAT('CUS', LPAD(next_id, 4, '0'));

    -- 4. Assign the new ID to the 'id' column of the new row
    SET NEW.id = formatted_id;
END
$$
DELIMITER ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `accounts`
--
ALTER TABLE `accounts`
  ADD PRIMARY KEY (`username`),
  ADD UNIQUE KEY `cart_id` (`cart_id`),
  ADD UNIQUE KEY `user_id` (`user_id`);

--
-- Indexes for table `cart`
--
ALTER TABLE `cart`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `Customer ID` (`Customer ID`);

--
-- Indexes for table `cart has items`
--
ALTER TABLE `cart has items`
  ADD PRIMARY KEY (`Cart ID`,`Item ID`),
  ADD KEY `Item ID` (`Item ID`);

--
-- Indexes for table `faqs`
--
ALTER TABLE `faqs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `invoice`
--
ALTER TABLE `invoice`
  ADD PRIMARY KEY (`ID`,`Cart ID`),
  ADD KEY `Cart ID` (`Cart ID`);

--
-- Indexes for table `invoice has items`
--
ALTER TABLE `invoice has items`
  ADD PRIMARY KEY (`Invoice ID`,`Cart ID`,`Item ID`),
  ADD KEY `Item ID` (`Item ID`);

--
-- Indexes for table `items`
--
ALTER TABLE `items`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `Item_type_id` (`Item_type_id`);

--
-- Indexes for table `item type`
--
ALTER TABLE `item type`
  ADD PRIMARY KEY (`Item_type_id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `faqs`
--
ALTER TABLE `faqs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `invoice`
--
ALTER TABLE `invoice`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `cart`
--
ALTER TABLE `cart`
  ADD CONSTRAINT `cart_ibfk_1` FOREIGN KEY (`ID`) REFERENCES `accounts` (`cart_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `cart_ibfk_2` FOREIGN KEY (`Customer ID`) REFERENCES `accounts` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `cart has items`
--
ALTER TABLE `cart has items`
  ADD CONSTRAINT `cart has items_ibfk_2` FOREIGN KEY (`Item ID`) REFERENCES `items` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `cart has items_ibfk_3` FOREIGN KEY (`Cart ID`) REFERENCES `cart` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `invoice`
--
ALTER TABLE `invoice`
  ADD CONSTRAINT `invoice_ibfk_1` FOREIGN KEY (`Cart ID`) REFERENCES `cart` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `invoice has items`
--
ALTER TABLE `invoice has items`
  ADD CONSTRAINT `invoice has items_ibfk_1` FOREIGN KEY (`Invoice ID`,`Cart ID`) REFERENCES `invoice` (`ID`, `Cart ID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `items`
--
ALTER TABLE `items`
  ADD CONSTRAINT `items_ibfk_1` FOREIGN KEY (`Item_type_id`) REFERENCES `item type` (`Item_type_id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
