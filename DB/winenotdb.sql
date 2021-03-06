-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema winenotdb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `winenotdb` ;

-- -----------------------------------------------------
-- Schema winenotdb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `winenotdb` DEFAULT CHARACTER SET utf8 ;
USE `winenotdb` ;

-- -----------------------------------------------------
-- Table `user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `user` ;

CREATE TABLE IF NOT EXISTS `user` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(45) NOT NULL,
  `password` VARCHAR(200) NOT NULL,
  `enabled` TINYINT NOT NULL DEFAULT 1,
  `role` VARCHAR(45) NULL,
  `email` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `wine_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `wine_type` ;

CREATE TABLE IF NOT EXISTS `wine_type` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `wine_type` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `wine_color`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `wine_color` ;

CREATE TABLE IF NOT EXISTS `wine_color` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `wine_color` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `wine`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `wine` ;

CREATE TABLE IF NOT EXISTS `wine` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `label_name` VARCHAR(100) NOT NULL,
  `vineyard` VARCHAR(100) NULL,
  `vintage_year` YEAR(4) NOT NULL,
  `flavor` VARCHAR(100) NOT NULL,
  `dietary` VARCHAR(100) NULL,
  `description` VARCHAR(2000) NOT NULL,
  `image` VARCHAR(2000) NULL,
  `pairs` VARCHAR(2000) NULL,
  `wine_type_id` INT NOT NULL,
  `wine_color_id` INT NOT NULL,
  `enabled` TINYINT NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  INDEX `fk_wine_wine_type1_idx` (`wine_type_id` ASC),
  INDEX `fk_wine_wine_color1_idx` (`wine_color_id` ASC),
  CONSTRAINT `fk_wine_wine_type1`
    FOREIGN KEY (`wine_type_id`)
    REFERENCES `wine_type` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_wine_wine_color1`
    FOREIGN KEY (`wine_color_id`)
    REFERENCES `wine_color` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `address`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `address` ;

CREATE TABLE IF NOT EXISTS `address` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `street` VARCHAR(100) NULL,
  `street2` VARCHAR(100) NULL,
  `city` VARCHAR(45) NULL,
  `state` CHAR(2) NULL,
  `zip` VARCHAR(45) NULL,
  `country` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `payment_info`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `payment_info` ;

CREATE TABLE IF NOT EXISTS `payment_info` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `address_id` INT NULL,
  `card_number` VARCHAR(45) NULL,
  `expr_date` DATE NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_payment_info_address1_idx` (`address_id` ASC),
  CONSTRAINT `fk_payment_info_address1`
    FOREIGN KEY (`address_id`)
    REFERENCES `address` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `customer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `customer` ;

CREATE TABLE IF NOT EXISTS `customer` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `birthdate` DATE NOT NULL,
  `address_id` INT NULL,
  `user_id` INT NOT NULL,
  `payment_info_id` INT NULL,
  `create_date` DATETIME NOT NULL,
  `customer_image` VARCHAR(2000) NULL,
  `bio` TEXT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_customer_address1_idx` (`address_id` ASC),
  INDEX `fk_customer_user1_idx` (`user_id` ASC),
  INDEX `fk_customer_payment_info1_idx` (`payment_info_id` ASC),
  CONSTRAINT `fk_customer_address1`
    FOREIGN KEY (`address_id`)
    REFERENCES `address` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_customer_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_customer_payment_info1`
    FOREIGN KEY (`payment_info_id`)
    REFERENCES `payment_info` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `customer_order`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `customer_order` ;

CREATE TABLE IF NOT EXISTS `customer_order` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `customer_id` INT NOT NULL,
  `order_date` DATETIME NULL,
  `amount` DECIMAL(6,2) NULL,
  `size` INT NULL,
  `wine_type_id` INT NULL,
  `wine_color_id` INT NULL,
  `processed` TINYINT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  INDEX `fk_subscription_customer1_idx` (`customer_id` ASC),
  INDEX `fk_order_wine_type1_idx` (`wine_type_id` ASC),
  INDEX `fk_order_wine_color1_idx` (`wine_color_id` ASC),
  CONSTRAINT `fk_subscription_customer1`
    FOREIGN KEY (`customer_id`)
    REFERENCES `customer` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_order_wine_type1`
    FOREIGN KEY (`wine_type_id`)
    REFERENCES `wine_type` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_order_wine_color1`
    FOREIGN KEY (`wine_color_id`)
    REFERENCES `wine_color` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `order_wine`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `order_wine` ;

CREATE TABLE IF NOT EXISTS `order_wine` (
  `order_id` INT NOT NULL,
  `wine_id` INT NOT NULL,
  `quantity` INT NOT NULL DEFAULT 1,
  PRIMARY KEY (`order_id`, `wine_id`),
  INDEX `fk_order_wine1_idx` (`wine_id` ASC),
  CONSTRAINT `fk_order_subscription1`
    FOREIGN KEY (`order_id`)
    REFERENCES `customer_order` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_order_wine1`
    FOREIGN KEY (`wine_id`)
    REFERENCES `wine` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `payment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `payment` ;

CREATE TABLE IF NOT EXISTS `payment` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `complete` TINYINT NULL,
  `order_id` INT NULL,
  `payment_date` DATETIME NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_payment_subscription1_idx` (`order_id` ASC),
  CONSTRAINT `fk_payment_subscription1`
    FOREIGN KEY (`order_id`)
    REFERENCES `customer_order` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `favorites`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `favorites` ;

CREATE TABLE IF NOT EXISTS `favorites` (
  `customer_id` INT NOT NULL,
  `wine_id` INT NOT NULL,
  PRIMARY KEY (`customer_id`, `wine_id`),
  INDEX `fk_favorites_wine1_idx` (`wine_id` ASC),
  CONSTRAINT `fk_favorites_customer1`
    FOREIGN KEY (`customer_id`)
    REFERENCES `customer` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_favorites_wine1`
    FOREIGN KEY (`wine_id`)
    REFERENCES `wine` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `review`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `review` ;

CREATE TABLE IF NOT EXISTS `review` (
  `image` VARCHAR(2000) NULL,
  `rating` INT NULL,
  `review` TEXT NULL,
  `customer_id` INT NOT NULL,
  `wine_id` INT NOT NULL,
  INDEX `fk_reviews_customer1_idx` (`customer_id` ASC),
  INDEX `fk_reviews_wine1_idx` (`wine_id` ASC),
  PRIMARY KEY (`customer_id`, `wine_id`),
  CONSTRAINT `fk_reviews_customer1`
    FOREIGN KEY (`customer_id`)
    REFERENCES `customer` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_reviews_wine1`
    FOREIGN KEY (`wine_id`)
    REFERENCES `wine` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SET SQL_MODE = '';
DROP USER IF EXISTS winenotuser@localhost;
SET SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
CREATE USER 'winenotuser'@'localhost' IDENTIFIED BY 'winenotuser';

GRANT SELECT, INSERT, TRIGGER, UPDATE, DELETE ON TABLE * TO 'winenotuser'@'localhost';

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `user`
-- -----------------------------------------------------
START TRANSACTION;
USE `winenotdb`;
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `email`) VALUES (1, 'admin', 'admin', 1, 'admin', 'admin@admin.org');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `email`) VALUES (2, 'fscott', 'password', 1, NULL, 'fscott@email.com');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`, `email`) VALUES (3, 'dpark', '123', 1, NULL, 'dpark@email.com');

COMMIT;


-- -----------------------------------------------------
-- Data for table `wine_type`
-- -----------------------------------------------------
START TRANSACTION;
USE `winenotdb`;
INSERT INTO `wine_type` (`id`, `wine_type`) VALUES (3, 'Chardonnay');
INSERT INTO `wine_type` (`id`, `wine_type`) VALUES (7, 'Pinot Grigio');
INSERT INTO `wine_type` (`id`, `wine_type`) VALUES (15, 'Sauvignon Blanc');
INSERT INTO `wine_type` (`id`, `wine_type`) VALUES (12, 'Rose');
INSERT INTO `wine_type` (`id`, `wine_type`) VALUES (8, 'Pinot Noir');
INSERT INTO `wine_type` (`id`, `wine_type`) VALUES (5, 'Merlot');
INSERT INTO `wine_type` (`id`, `wine_type`) VALUES (2, 'Cabernet');
INSERT INTO `wine_type` (`id`, `wine_type`) VALUES (4, 'Malbec');
INSERT INTO `wine_type` (`id`, `wine_type`) VALUES (13, 'Rosso');
INSERT INTO `wine_type` (`id`, `wine_type`) VALUES (10, 'Red Blend');
INSERT INTO `wine_type` (`id`, `wine_type`) VALUES (18, 'Zinfandel');
INSERT INTO `wine_type` (`id`, `wine_type`) VALUES (11, 'Riesling');
INSERT INTO `wine_type` (`id`, `wine_type`) VALUES (6, 'Moscato');
INSERT INTO `wine_type` (`id`, `wine_type`) VALUES (9, 'Port');
INSERT INTO `wine_type` (`id`, `wine_type`) VALUES (14, 'Sangria');
INSERT INTO `wine_type` (`id`, `wine_type`) VALUES (16, 'Sparkling');
INSERT INTO `wine_type` (`id`, `wine_type`) VALUES (1, 'Bordeaux');
INSERT INTO `wine_type` (`id`, `wine_type`) VALUES (17, 'Syrah');
INSERT INTO `wine_type` (`id`, `wine_type`) VALUES (19, 'Sangiovese');

COMMIT;


-- -----------------------------------------------------
-- Data for table `wine_color`
-- -----------------------------------------------------
START TRANSACTION;
USE `winenotdb`;
INSERT INTO `wine_color` (`id`, `wine_color`) VALUES (1, 'red');
INSERT INTO `wine_color` (`id`, `wine_color`) VALUES (2, 'white');
INSERT INTO `wine_color` (`id`, `wine_color`) VALUES (3, 'rose');
INSERT INTO `wine_color` (`id`, `wine_color`) VALUES (4, 'mixed');

COMMIT;


-- -----------------------------------------------------
-- Data for table `wine`
-- -----------------------------------------------------
START TRANSACTION;
USE `winenotdb`;
INSERT INTO `wine` (`id`, `label_name`, `vineyard`, `vintage_year`, `flavor`, `dietary`, `description`, `image`, `pairs`, `wine_type_id`, `wine_color_id`, `enabled`) VALUES (1, 'Kendall-Jackson Vintner\'s Reserve', 'Kendall-Jackson, California USA', 2018, 'Semi-dry, refreshing', NULL, 'Refreshing. Hint of toasted oak and butter.', 'https://www.kj.com/sites/default/files/styles/bottle_desktop/public/bottle-shots/kjvr-chard-nv.png?itok=gQhUHaDa', 'Fish, chicken, pasta', 3, 2, DEFAULT);
INSERT INTO `wine` (`id`, `label_name`, `vineyard`, `vintage_year`, `flavor`, `dietary`, `description`, `image`, `pairs`, `wine_type_id`, `wine_color_id`, `enabled`) VALUES (2, 'Jordan', 'Jordan, Alexander Valley, Sonoma County, California', 2015, 'Dry, savory', NULL, 'Aromas of black cherry, pomengranate. Hint graphite channel classic bordeau? ', 'https://images.vivino.com/thumbs/qjHLWYYuSm22OSv-zy8O6g_pb_x600.png', NULL, 2, 1, DEFAULT);
INSERT INTO `wine` (`id`, `label_name`, `vineyard`, `vintage_year`, `flavor`, `dietary`, `description`, `image`, `pairs`, `wine_type_id`, `wine_color_id`, `enabled`) VALUES (3, 'Mogen David-Concord Kosher Wine NV', 'California', 2015, 'Sweet', 'Kosher', 'Dessert. Sweet. Fruity. Tasty.', 'https://www.wine-searcher.com/images/labels/33/48/10423348.jpg', NULL, 10, 1, DEFAULT);
INSERT INTO `wine` (`id`, `label_name`, `vineyard`, `vintage_year`, `flavor`, `dietary`, `description`, `image`, `pairs`, `wine_type_id`, `wine_color_id`, `enabled`) VALUES (4, 'Montpellier, California', 'Montpellier Vineyards', 2015, 'Sweet with a smooth finish', NULL, 'Hints of blueberry, raspberry, cherry on the nose. With a smooth finish.', 'https://broncowine.com/wp-content/uploads/2017/01/montpellier_MR_thumb.jpg', 'Chargrilled steak, roast beef, roast lamb', 5, 1, DEFAULT);
INSERT INTO `wine` (`id`, `label_name`, `vineyard`, `vintage_year`, `flavor`, `dietary`, `description`, `image`, `pairs`, `wine_type_id`, `wine_color_id`, `enabled`) VALUES (5, 'Sandeman Quinta Seixo Vintage', 'Sogrape Vinhos', 2017, 'Sweet', NULL, 'Notes of black and red fruit, shrubby tones, spices and hints of balsamic that harmonize perfectly with additional notes of shale/slate.', 'https://www.wine.com/product/images/w_1024,h_3328,c_fit,q_auto:good,fl_progressive/tmhww2u4esonk4higd3f.jpg', NULL, 9, 1, DEFAULT);
INSERT INTO `wine` (`id`, `label_name`, `vineyard`, `vintage_year`, `flavor`, `dietary`, `description`, `image`, `pairs`, `wine_type_id`, `wine_color_id`, `enabled`) VALUES (6, 'Kim Crawford', 'Auckland, New Zealand', 2016, 'Dry', NULL, 'Fresh and juicy with ripe, tropical flavors of passion fruit, melon, and stone fruit', 'https://products3.imgix.drizly.com/ci-kim-crawford-sauvignon-blanc-3e0d9d465b786741.jpeg?auto=format%2Ccompress&fm=jpg&q=20', 'Shellfish, Salads & Greens', 15, 2, DEFAULT);
INSERT INTO `wine` (`id`, `label_name`, `vineyard`, `vintage_year`, `flavor`, `dietary`, `description`, `image`, `pairs`, `wine_type_id`, `wine_color_id`, `enabled`) VALUES (7, 'Cote des Roses ', 'Languedoc, South of France, France', 2019, 'Semi Dry', NULL, 'Aromas of summer fruits, cassis, and redcurrant. Floral notes of rose along with hints of grapefruit complete the picture. The finish is fresh, offering notes of candy.', 'https://www.wine.com/product/images/w_768,h_2792,c_fit,q_auto:good,fl_progressive/fke19zugzdjgzif1iniw.jpg', 'Shellfish and subtly spiced dishes', 12, 3, DEFAULT);
INSERT INTO `wine` (`id`, `label_name`, `vineyard`, `vintage_year`, `flavor`, `dietary`, `description`, `image`, `pairs`, `wine_type_id`, `wine_color_id`, `enabled`) VALUES (8, 'Rivata Moscato D\'Asti', 'Rivata Piedmont, Italy', 2018, 'Sweet', NULL, 'Peach, mango, honey flowers.', 'https://www.totalwine.com/dynamic/x1000,sq/media/sys_master/twmmedia/h45/h9e/9923600318494.png', 'Spicy pork appetizers', 6, 2, DEFAULT);
INSERT INTO `wine` (`id`, `label_name`, `vineyard`, `vintage_year`, `flavor`, `dietary`, `description`, `image`, `pairs`, `wine_type_id`, `wine_color_id`, `enabled`) VALUES (9, 'PALO61, Toscano Rosso IGT No. 07', 'Tenuta Santa Lucia', 2019, 'Sweet', 'Paleo', 'This wine is produced from Ciliegiolo (cee-lee-a-jo-low aka “cherry-grape”) grapes grown in the low-yielding vineyard of the Tenuta Santa Lucia on coastal Tuscany near Pisa.', 'https://www.seccowineclub.com/wp-content/uploads/PALO61back-nutrition-label-FULLSIZE.png', '\nIdeal with both white and red meat, game, fresh and aged cheeses', 13, 1, DEFAULT);
INSERT INTO `wine` (`id`, `label_name`, `vineyard`, `vintage_year`, `flavor`, `dietary`, `description`, `image`, `pairs`, `wine_type_id`, `wine_color_id`, `enabled`) VALUES (10, 'Poema Cava Brut Rose', 'Penedes, Spain', 2019, 'Semi Sweet', NULL, 'Fresh and elegant notes of strawberry, raspberry and rose petals.', 'https://www.wine.com/product/images/w_480,h_600,c_fit,q_auto:good,fl_progressive/fwluk204spzg6uf9zpvl.jpg', 'Cold cuts, barbecue, small game and lightly smoked fish.', 16, 3, DEFAULT);
INSERT INTO `wine` (`id`, `label_name`, `vineyard`, `vintage_year`, `flavor`, `dietary`, `description`, `image`, `pairs`, `wine_type_id`, `wine_color_id`, `enabled`) VALUES (11, 'Mothers Choice Organic Red Blend', 'California, USA', 2019, 'Sweet', 'Organic', 'Luscious combination of dark fruits, balanced with cherry and toasted oak', 'https://d2x2m7pk1sz8q7.cloudfront.net/pub/media/catalog/product/cache/6b02b565ece6ddd28e38409c97985f74/m/o/motherschoice-red_1_1_1.jpg', NULL, 10, 1, DEFAULT);
INSERT INTO `wine` (`id`, `label_name`, `vineyard`, `vintage_year`, `flavor`, `dietary`, `description`, `image`, `pairs`, `wine_type_id`, `wine_color_id`, `enabled`) VALUES (12, 'Relax', 'Mosel-Saar-Ruhr, Germany', 2019, 'Semi-Sweet', NULL, 'Intense flavors of apples and peaches with a hint of citrus.', 'https://kingsvalleywineandspirits.com/wp-content/uploads/2018/10/Relax-Riesling-Blue.jpg', NULL, 11, 2, DEFAULT);
INSERT INTO `wine` (`id`, `label_name`, `vineyard`, `vintage_year`, `flavor`, `dietary`, `description`, `image`, `pairs`, `wine_type_id`, `wine_color_id`, `enabled`) VALUES (13, 'La Crema Sonoma Coast', 'Sonoma Coast, California, USA', 2018, 'Semi-Dry', NULL, 'Aromas of meyer lemon, gala apple and subtle hints of OAK are followed by flavors of white stone fruit, yellow plum and honeydew melon. On the palate, the wine is vibrant and concentrated with juicy acidity that drives a lingering finish.', 'https://www.totalwine.com/dynamic/x1000,sq/media/sys_master/twmmedia/h04/h1a/12104360820766.png', NULL, 3, 2, DEFAULT);
INSERT INTO `wine` (`id`, `label_name`, `vineyard`, `vintage_year`, `flavor`, `dietary`, `description`, `image`, `pairs`, `wine_type_id`, `wine_color_id`, `enabled`) VALUES (14, '19 Crimes The Punishment', 'South Eastern Australia, Australia', 2019, 'Dry', NULL, 'Medium bodied with soft, round tannins, cherry and strawberry fruit sweetness which complements the vanilla and spice oak undertones. All these elements combined create a well-balanced, enjoyable wine with a long finish.', 'https://www.totalwine.com/dynamic/x1000,sq/media/sys_master/twmmedia/hb1/hde/12958633394206.png', NULL, 8, 1, DEFAULT);
INSERT INTO `wine` (`id`, `label_name`, `vineyard`, `vintage_year`, `flavor`, `dietary`, `description`, `image`, `pairs`, `wine_type_id`, `wine_color_id`, `enabled`) VALUES (15, 'Seghesio Sonoma', 'Seghesio Sonoma County, California, USA', 2018, 'Sweet', NULL, 'With a bouquet of cedar, spice, and sun-ripened blackberries, our Sonoma Zinfandel makes a strong first impression. Bold and richly textured on the palate with an intensity and purity of fruit reflected in notes of wild blueberries, plum, and black currants. A light dusting of tannins provides structure and a long finish that is boueyed by fresh juicy acidity.', 'https://www.wine.com/product/images/w_1440,h_5936,c_fit,q_auto:good,fl_progressive/lrewdud5913poppljrez.jpg', 'Red sauces, pizza, and barbeque, as well as sopressata and dry jack.', 18, 1, DEFAULT);
INSERT INTO `wine` (`id`, `label_name`, `vineyard`, `vintage_year`, `flavor`, `dietary`, `description`, `image`, `pairs`, `wine_type_id`, `wine_color_id`, `enabled`) VALUES (16, 'Fleurs de Prairie Rose', 'Provence, France', 2019, 'Semi-Dry', NULL, 'Delicate flavors of strawberry, rose petals, and herbs, and a bright, refreshing acidity.', 'https://cdn.shopify.com/s/files/1/0062/7775/9094/products/Fleurs_de_Prairie_Rose_2018_bottle_900x1350.png', NULL, 12, 3, DEFAULT);
INSERT INTO `wine` (`id`, `label_name`, `vineyard`, `vintage_year`, `flavor`, `dietary`, `description`, `image`, `pairs`, `wine_type_id`, `wine_color_id`, `enabled`) VALUES (17, 'Gerard Bertrand Cote Des Roses', 'Languedoc-Roussillon, France', 2019, 'Dry', NULL, 'Notes of mango, dried fruits and hazelnut and aromas of grape fruits and orange blossom.', 'https://products0.imgix.drizly.com/ci-gerard-bertrand-cote-des-roses-chardonnay-711bd9ee343495dd.jpeg', 'Fish - Meaty & Oily, Shellfish, Cheese - Fresh & Soft', 3, 2, DEFAULT);
INSERT INTO `wine` (`id`, `label_name`, `vineyard`, `vintage_year`, `flavor`, `dietary`, `description`, `image`, `pairs`, `wine_type_id`, `wine_color_id`, `enabled`) VALUES (18, 'Durand Sancerre', 'Loire, France', 2018, 'Dry', NULL, 'Notes of citrus, apple and gooseberry with hints of passion fruit.', 'https://products2.imgix.drizly.com/ci-durand-sancerre-2016-bdb934ed883d9c1a.jpeg', 'Chicken, Cheese - Fresh & Soft', 15, 2, DEFAULT);
INSERT INTO `wine` (`id`, `label_name`, `vineyard`, `vintage_year`, `flavor`, `dietary`, `description`, `image`, `pairs`, `wine_type_id`, `wine_color_id`, `enabled`) VALUES (19, 'Bodegas Breca Rose', 'Aragon, Spain', 2018, 'Semi-Dry', NULL, 'Berry, watermelon, spice and vanilla flavors mingle in a plush texture, with just enough acidity to stay focused.', 'https://www.wine.com/product/images/w_480,h_600,c_fit,q_auto:good,fl_progressive/ljey9wdtecotiyonx3sd.jpg', NULL, 12, 3, DEFAULT);
INSERT INTO `wine` (`id`, `label_name`, `vineyard`, `vintage_year`, `flavor`, `dietary`, `description`, `image`, `pairs`, `wine_type_id`, `wine_color_id`, `enabled`) VALUES (20, 'Bonny Doon Vin Gris de Cigare', 'Central Coast, California', 2019, 'Semi-Dry', NULL, 'Wild strawberry, peach, guava, and rhubarb and a very discreet scent of white pepper. ', 'https://www.wine.com/product/images/w_768,h_2304,c_fit,q_auto:good,fl_progressive/lsec7bmkewq4qbw1uop1.jpg', NULL, 12, 3, DEFAULT);
INSERT INTO `wine` (`id`, `label_name`, `vineyard`, `vintage_year`, `flavor`, `dietary`, `description`, `image`, `pairs`, `wine_type_id`, `wine_color_id`, `enabled`) VALUES (21, 'Cambria Julia\'s Vineyard Rose of Pinot Noir', 'Santa Maria Valley, Central Coast, California', 2018, 'Semi-Dry', NULL, 'Pronounced aromas of white peach, strawberry, and citrus. The palate is medium-bodied, with balancing and refreshing acidity, leading to a finish that expresses watermelon and grapefruit.', 'https://www.wine.com/product/images/w_1024,h_3773,c_fit,q_auto:good,fl_progressive/jhkxzcb1dxxw5n3zrpy3.jpg', 'Cast iron barbecue shrimp', 8, 3, DEFAULT);
INSERT INTO `wine` (`id`, `label_name`, `vineyard`, `vintage_year`, `flavor`, `dietary`, `description`, `image`, `pairs`, `wine_type_id`, `wine_color_id`, `enabled`) VALUES (22, 'Morgans', 'Central, USA', 2015, 'Sweet', NULL, 'Smoky hints of Mango', NULL, 'Pho', 18, 1, DEFAULT);
INSERT INTO `wine` (`id`, `label_name`, `vineyard`, `vintage_year`, `flavor`, `dietary`, `description`, `image`, `pairs`, `wine_type_id`, `wine_color_id`, `enabled`) VALUES (23, 'Claire', 'Barcelona, Spain', 2016, 'Dry', NULL, 'Notes of blackberry', NULL, 'Pastas and salads', 14, 1, DEFAULT);
INSERT INTO `wine` (`id`, `label_name`, `vineyard`, `vintage_year`, `flavor`, `dietary`, `description`, `image`, `pairs`, `wine_type_id`, `wine_color_id`, `enabled`) VALUES (24, 'Maegan', 'Toronto, Canada', 2017, 'Semi-Dry', NULL, 'Notes of apple with a hint of lemon', NULL, 'Cast iron char grilled steak.', 9, 1, DEFAULT);
INSERT INTO `wine` (`id`, `label_name`, `vineyard`, `vintage_year`, `flavor`, `dietary`, `description`, `image`, `pairs`, `wine_type_id`, `wine_color_id`, `enabled`) VALUES (25, 'Phantom Bandit', 'Kansas, USA', 2018, 'Semi-Sweet', 'Organic', 'Flavors of elderberry', NULL, 'Meats', 14, 1, DEFAULT);
INSERT INTO `wine` (`id`, `label_name`, `vineyard`, `vintage_year`, `flavor`, `dietary`, `description`, `image`, `pairs`, `wine_type_id`, `wine_color_id`, `enabled`) VALUES (26, 'Sparrow Hawk 12', 'Tortuga, Caribbean', 2019, 'Sweet', NULL, 'Notes of tropical fruit.', NULL, NULL, 8, 1, DEFAULT);
INSERT INTO `wine` (`id`, `label_name`, `vineyard`, `vintage_year`, `flavor`, `dietary`, `description`, `image`, `pairs`, `wine_type_id`, `wine_color_id`, `enabled`) VALUES (27, 'S\'mols Argen', 'Southern Steppe, Mongolia', 2020, 'Savory', 'Kosher', 'Blackcherry flavors leave a hint of smoky pear.', NULL, NULL, 17, 1, DEFAULT);
INSERT INTO `wine` (`id`, `label_name`, `vineyard`, `vintage_year`, `flavor`, `dietary`, `description`, `image`, `pairs`, `wine_type_id`, `wine_color_id`, `enabled`) VALUES (28, 'Athen\'s Grace', 'Athens, Greece', 1990, 'Sweet', NULL, 'Aromas of blackcherry mix tantilizingly with an apple after taste', NULL, 'Seafood', 4, 1, DEFAULT);
INSERT INTO `wine` (`id`, `label_name`, `vineyard`, `vintage_year`, `flavor`, `dietary`, `description`, `image`, `pairs`, `wine_type_id`, `wine_color_id`, `enabled`) VALUES (29, 'Scopazzi Bros', 'Central Vietnam', 2000, 'Dry', 'Organic', 'Unites satirical clam overtones with a flirtatious onion aroma.', NULL, 'Starches', 7, 2, DEFAULT);
INSERT INTO `wine` (`id`, `label_name`, `vineyard`, `vintage_year`, `flavor`, `dietary`, `description`, `image`, `pairs`, `wine_type_id`, `wine_color_id`, `enabled`) VALUES (30, 'Jose Rodriguez', 'Southern Georgia, USA', 2008, 'Dry', NULL, 'A grimy wheat perfume and better-than-most mustard flavors', NULL, NULL, 15, 2, DEFAULT);
INSERT INTO `wine` (`id`, `label_name`, `vineyard`, `vintage_year`, `flavor`, `dietary`, `description`, `image`, `pairs`, `wine_type_id`, `wine_color_id`, `enabled`) VALUES (31, 'Soprano Family', 'Western Australia', 1995, 'Semi-Sweet', NULL, 'A uninhibited spelt perfume and soporiphic clam overtones', NULL, 'Prawn on the barbie', 11, 2, DEFAULT);
INSERT INTO `wine` (`id`, `label_name`, `vineyard`, `vintage_year`, `flavor`, `dietary`, `description`, `image`, `pairs`, `wine_type_id`, `wine_color_id`, `enabled`) VALUES (32, 'Dean Lamb \'17', 'Cypress Creek Vineyards', 2004, 'Refreshingly dry', 'Palei', 'Ambitious corn midtones and a impossible-to-detect coffee aroma', NULL, NULL, 3, 2, DEFAULT);
INSERT INTO `wine` (`id`, `label_name`, `vineyard`, `vintage_year`, `flavor`, `dietary`, `description`, `image`, `pairs`, `wine_type_id`, `wine_color_id`, `enabled`) VALUES (33, 'Champs de Fournier', 'Eastern Brazil', 2011, 'Sweet', NULL, '\nA scintillating ammonia bouquet and citrus essences', NULL, NULL, 6, 2, DEFAULT);
INSERT INTO `wine` (`id`, `label_name`, `vineyard`, `vintage_year`, `flavor`, `dietary`, `description`, `image`, `pairs`, `wine_type_id`, `wine_color_id`, `enabled`) VALUES (34, 'Bob\'s Chenin', 'Sticks, New York', 1991, 'Dry and Savory', NULL, 'Decadent rasberry elements', NULL, NULL, 16, 2, DEFAULT);
INSERT INTO `wine` (`id`, `label_name`, `vineyard`, `vintage_year`, `flavor`, `dietary`, `description`, `image`, `pairs`, `wine_type_id`, `wine_color_id`, `enabled`) VALUES (35, 'Chateau Molyneaux', 'Paris, France', 2010, 'Sweet and Bitter', NULL, 'Explicit walnut undertones', NULL, NULL, 16, 2, DEFAULT);
INSERT INTO `wine` (`id`, `label_name`, `vineyard`, `vintage_year`, `flavor`, `dietary`, `description`, `image`, `pairs`, `wine_type_id`, `wine_color_id`, `enabled`) VALUES (36, 'Redwood Canyon', 'Southern Texas, USA', 1996, 'Semi-Sweet', NULL, 'Mild whitefish undertones and a non-toxic bean curd aftertaste', NULL, NULL, 16, 2, DEFAULT);
INSERT INTO `wine` (`id`, `label_name`, `vineyard`, `vintage_year`, `flavor`, `dietary`, `description`, `image`, `pairs`, `wine_type_id`, `wine_color_id`, `enabled`) VALUES (37, 'Scopelli', 'Semillon, England', 1990, 'Arid Dry', NULL, 'Well-hidden acetone midtones with a gritty brussels sprout flavor.', NULL, NULL, 12, 3, DEFAULT);
INSERT INTO `wine` (`id`, `label_name`, `vineyard`, `vintage_year`, `flavor`, `dietary`, `description`, `image`, `pairs`, `wine_type_id`, `wine_color_id`, `enabled`) VALUES (38, 'Acme Corporation', 'Somewhere, Utah', 1992, 'Dry and Savory', NULL, 'A hallucinogenic sushi bouquet and mildewed bubble gum elements', NULL, NULL, 16, 3, DEFAULT);
INSERT INTO `wine` (`id`, `label_name`, `vineyard`, `vintage_year`, `flavor`, `dietary`, `description`, `image`, `pairs`, `wine_type_id`, `wine_color_id`, `enabled`) VALUES (39, 'Scoliosis Winery', 'Las Vegas, NV, USA', 2001, 'Sweet and Savory', NULL, 'A cantankerous molasses aroma and full-bodied ketchup essences', NULL, NULL, 12, 3, DEFAULT);
INSERT INTO `wine` (`id`, `label_name`, `vineyard`, `vintage_year`, `flavor`, `dietary`, `description`, `image`, `pairs`, `wine_type_id`, `wine_color_id`, `enabled`) VALUES (40, 'Skunk Meadows', 'Dublin, Ireland', 2008, 'Dry', NULL, 'Outspoken parsnip overtones with a soapy sour cream finish.', NULL, NULL, 16, 3, DEFAULT);
INSERT INTO `wine` (`id`, `label_name`, `vineyard`, `vintage_year`, `flavor`, `dietary`, `description`, `image`, `pairs`, `wine_type_id`, `wine_color_id`, `enabled`) VALUES (41, 'Champs de Rissacher', 'Camp Kinzer, Okinawa', 2009, 'Sweet', NULL, 'Piquant egg flavors and a acrid sawdust.', NULL, NULL, 12, 3, DEFAULT);
INSERT INTO `wine` (`id`, `label_name`, `vineyard`, `vintage_year`, `flavor`, `dietary`, `description`, `image`, `pairs`, `wine_type_id`, `wine_color_id`, `enabled`) VALUES (42, 'Unreliable', 'Alkie Vineyards', 2002, 'Arid', NULL, 'Crusty halibut overtones with a smoky vinegar aftertaste.', NULL, NULL, 12, 3, DEFAULT);
INSERT INTO `wine` (`id`, `label_name`, `vineyard`, `vintage_year`, `flavor`, `dietary`, `description`, `image`, `pairs`, `wine_type_id`, `wine_color_id`, `enabled`) VALUES (43, 'Chateau La Fontaigne', 'Monarch Gates, Terra 2', 2012, 'Semi-Sweet', NULL, 'A violent wood chip perfume and acidic chocolate flavors ', NULL, NULL, 12, 3, DEFAULT);
INSERT INTO `wine` (`id`, `label_name`, `vineyard`, `vintage_year`, `flavor`, `dietary`, `description`, `image`, `pairs`, `wine_type_id`, `wine_color_id`, `enabled`) VALUES (44, 'Mussolini Bros CroaRose', 'Boulder, Colorado', 1995, 'Extra Dry', NULL, 'Marigold undertones and a cryptic white pepper flavor', NULL, NULL, 16, 3, DEFAULT);
INSERT INTO `wine` (`id`, `label_name`, `vineyard`, `vintage_year`, `flavor`, `dietary`, `description`, `image`, `pairs`, `wine_type_id`, `wine_color_id`, `enabled`) VALUES (45, 'Firefly Rosy Cheek', 'West Grizzlies', 1997, 'Extra Sweet', NULL, 'Lavender notes with a blueberry undertone', NULL, NULL, 12, 3, DEFAULT);
INSERT INTO `wine` (`id`, `label_name`, `vineyard`, `vintage_year`, `flavor`, `dietary`, `description`, `image`, `pairs`, `wine_type_id`, `wine_color_id`, `enabled`) VALUES (46, 'Liogueil Száraz', 'Knott\'s Berry Farm', 1998, 'Extra Dry', NULL, 'Kicks you with toothpaste, closed french onion soup and perceptable skittle.', NULL, NULL, 1, 1, DEFAULT);
INSERT INTO `wine` (`id`, `label_name`, `vineyard`, `vintage_year`, `flavor`, `dietary`, `description`, `image`, `pairs`, `wine_type_id`, `wine_color_id`, `enabled`) VALUES (47, 'Pausne Adamado', 'Tokushima, Japan', 1999, 'Sweet', NULL, 'Drops pixie stick, focused jack cheese and forward slim jims.', NULL, NULL, 2, 1, DEFAULT);
INSERT INTO `wine` (`id`, `label_name`, `vineyard`, `vintage_year`, `flavor`, `dietary`, `description`, `image`, `pairs`, `wine_type_id`, `wine_color_id`, `enabled`) VALUES (48, 'Brilage Edes', 'Deadhorse, United States', 2000, 'Dry', NULL, 'Forcefully bites you with saltine, extra-ripe hair-spray and perceptable cactus.', NULL, NULL, 3, 2, DEFAULT);
INSERT INTO `wine` (`id`, `label_name`, `vineyard`, `vintage_year`, `flavor`, `dietary`, `description`, `image`, `pairs`, `wine_type_id`, `wine_color_id`, `enabled`) VALUES (49, 'Cetage', 'Maracay, Venezuela', 2001, 'Extra Sweet', NULL, 'Attacks with string cheese, sassy poi and atomic traces of pork rind.', NULL, NULL, 4, 1, DEFAULT);
INSERT INTO `wine` (`id`, `label_name`, `vineyard`, `vintage_year`, `flavor`, `dietary`, `description`, `image`, `pairs`, `wine_type_id`, `wine_color_id`, `enabled`) VALUES (50, 'Reigdofe', 'Cockburn Town, United Kingdom', 2002, 'Semi Sweet', NULL, 'Shows whole-wheat bread, intense buttermilk pancakes and atomic traces of pesto.', NULL, NULL, 5, 1, DEFAULT);
INSERT INTO `wine` (`id`, `label_name`, `vineyard`, `vintage_year`, `flavor`, `dietary`, `description`, `image`, `pairs`, `wine_type_id`, `wine_color_id`, `enabled`) VALUES (51, 'Dueinchuemes Garrafeira', 'Chelyabinsk, Russia', 2003, 'Semi Dry', NULL, 'Kicks you with taco sauce, zealous ganja and lingering hot dog water. ', NULL, NULL, 6, 2, DEFAULT);
INSERT INTO `wine` (`id`, `label_name`, `vineyard`, `vintage_year`, `flavor`, `dietary`, `description`, `image`, `pairs`, `wine_type_id`, `wine_color_id`, `enabled`) VALUES (52, 'Qeertzewen Adega', 'Sekondi-Takoradi, Ghana', 2004, 'Sweet Savory', NULL, 'Whispers of Mars bar, underdone oysters and atomic traces of lime zest.', NULL, NULL, 7, 2, DEFAULT);
INSERT INTO `wine` (`id`, `label_name`, `vineyard`, `vintage_year`, `flavor`, `dietary`, `description`, `image`, `pairs`, `wine_type_id`, `wine_color_id`, `enabled`) VALUES (53, 'Ghembluvrey Invecchiato', 'Lisbon, Portugal', 2005, 'Dry Refreshing', NULL, 'Opens with hair gel, understated teriyaki and strong-willed opium.', NULL, NULL, 8, 1, DEFAULT);
INSERT INTO `wine` (`id`, `label_name`, `vineyard`, `vintage_year`, `flavor`, `dietary`, `description`, `image`, `pairs`, `wine_type_id`, `wine_color_id`, `enabled`) VALUES (54, 'Grozonel Noir', 'Semarang, Indonesia', 1985, 'Dry Savory', NULL, 'Resembles clam chowder, whimsical dishwater and forward toothpaste.', NULL, NULL, 9, 1, DEFAULT);
INSERT INTO `wine` (`id`, `label_name`, `vineyard`, `vintage_year`, `flavor`, `dietary`, `description`, `image`, `pairs`, `wine_type_id`, `wine_color_id`, `enabled`) VALUES (55, 'Xarie Viejo', 'Aracaju, Brazil\n', 1987, 'Sweet Refreshing', NULL, 'Hits you with sage, boggling cardboard and bashful mint.', NULL, NULL, 10, 3, DEFAULT);
INSERT INTO `wine` (`id`, `label_name`, `vineyard`, `vintage_year`, `flavor`, `dietary`, `description`, `image`, `pairs`, `wine_type_id`, `wine_color_id`, `enabled`) VALUES (56, 'Gisone Granvas', 'Santa Fe, Argentina', 1999, 'Semi-Dry Savory', NULL, 'Forces smoked oyster, acidic monster gasoline and corpulent jack cheese.', NULL, NULL, 11, 2, DEFAULT);
INSERT INTO `wine` (`id`, `label_name`, `vineyard`, `vintage_year`, `flavor`, `dietary`, `description`, `image`, `pairs`, `wine_type_id`, `wine_color_id`, `enabled`) VALUES (57, 'Ibles Noir', 'Bilbao, Spain', 1986, 'Sweet', NULL, 'Notes of orange peel, seedless watermelon.', NULL, NULL, 12, 3, DEFAULT);
INSERT INTO `wine` (`id`, `label_name`, `vineyard`, `vintage_year`, `flavor`, `dietary`, `description`, `image`, `pairs`, `wine_type_id`, `wine_color_id`, `enabled`) VALUES (58, 'Dhocati Branco', 'Kandahar, Afghanistan', 1978, 'Dry', NULL, 'Hints of meandering mint.', NULL, NULL, 13, 1, DEFAULT);
INSERT INTO `wine` (`id`, `label_name`, `vineyard`, `vintage_year`, `flavor`, `dietary`, `description`, `image`, `pairs`, `wine_type_id`, `wine_color_id`, `enabled`) VALUES (59, 'Pesorol Viejo', 'Nassau, Bahamas', 1977, 'Dry', NULL, 'Slippery macademia nut essences with a spicy tofu finish.', NULL, NULL, 14, 3, DEFAULT);
INSERT INTO `wine` (`id`, `label_name`, `vineyard`, `vintage_year`, `flavor`, `dietary`, `description`, `image`, `pairs`, `wine_type_id`, `wine_color_id`, `enabled`) VALUES (60, 'Ipligiens Cépage', 'Isfahan, Iran', 1976, 'Semi Dry', NULL, 'Coalesces ambitious Kool-Aid overtones and a fishy spearmint essence', NULL, NULL, 15, 2, DEFAULT);
INSERT INTO `wine` (`id`, `label_name`, `vineyard`, `vintage_year`, `flavor`, `dietary`, `description`, `image`, `pairs`, `wine_type_id`, `wine_color_id`, `enabled`) VALUES (61, 'Minduebria Adega', 'Denver, United States', 1972, 'Sweet Dry', NULL, 'A tummy-tickling oatmeal perfume and unremarkable lavender elements', NULL, NULL, 16, 3, DEFAULT);
INSERT INTO `wine` (`id`, `label_name`, `vineyard`, `vintage_year`, `flavor`, `dietary`, `description`, `image`, `pairs`, `wine_type_id`, `wine_color_id`, `enabled`) VALUES (62, 'Trechot Dolce', 'Lomé, Togo', 1971, 'Extra Semi Sweet', NULL, 'Introverted parsnip midtones and a well-hidden coffee aftertaste', NULL, NULL, 17, 1, DEFAULT);
INSERT INTO `wine` (`id`, `label_name`, `vineyard`, `vintage_year`, `flavor`, `dietary`, `description`, `image`, `pairs`, `wine_type_id`, `wine_color_id`, `enabled`) VALUES (63, 'Pachage Abboccato', 'Enschede, Netherlands', 1965, 'Dry', NULL, 'Latino mesquite flavors with a sleep-inducing fruit bouquet.', NULL, NULL, 18, 1, DEFAULT);
INSERT INTO `wine` (`id`, `label_name`, `vineyard`, `vintage_year`, `flavor`, `dietary`, `description`, `image`, `pairs`, `wine_type_id`, `wine_color_id`, `enabled`) VALUES (64, 'Fliennina Noir', 'San Juan, United States', 1961, 'Tangy', NULL, 'A sugary turpentine flavor and oaty Cool Whip undertones', NULL, NULL, 19, 3, DEFAULT);

COMMIT;


-- -----------------------------------------------------
-- Data for table `address`
-- -----------------------------------------------------
START TRANSACTION;
USE `winenotdb`;
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (1, '800 Victor St', NULL, 'Salinas', 'CA', '93907', 'USA');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (2, '599 Summit Ave', NULL, 'St Paul', 'MN', '55102', 'USA');
INSERT INTO `address` (`id`, `street`, `street2`, `city`, `state`, `zip`, `country`) VALUES (3, '310 W 80th Street', NULL, 'New York', 'NY', '10024', 'USA');

COMMIT;


-- -----------------------------------------------------
-- Data for table `payment_info`
-- -----------------------------------------------------
START TRANSACTION;
USE `winenotdb`;
INSERT INTO `payment_info` (`id`, `address_id`, `card_number`, `expr_date`) VALUES (1, 1, '12345678', '1870-06-09');
INSERT INTO `payment_info` (`id`, `address_id`, `card_number`, `expr_date`) VALUES (2, 2, '1234123412', '1940-12-22');
INSERT INTO `payment_info` (`id`, `address_id`, `card_number`, `expr_date`) VALUES (3, 3, '1234123412341234', '1967-06-07');

COMMIT;


-- -----------------------------------------------------
-- Data for table `customer`
-- -----------------------------------------------------
START TRANSACTION;
USE `winenotdb`;
INSERT INTO `customer` (`id`, `first_name`, `last_name`, `birthdate`, `address_id`, `user_id`, `payment_info_id`, `create_date`, `customer_image`, `bio`) VALUES (1, 'Charles', 'Dickens', '1812-02-07', 1, 1, 1, '1870-06-08', 'https://upload.wikimedia.org/wikipedia/commons/a/aa/Dickens_Gurney_head.jpg', 'Sad boi.');
INSERT INTO `customer` (`id`, `first_name`, `last_name`, `birthdate`, `address_id`, `user_id`, `payment_info_id`, `create_date`, `customer_image`, `bio`) VALUES (2, 'Francis', 'Fitzgerald', '1896-09-24', 2, 2, 2, '1940-12-21', NULL, 'Alcoholic writer.');
INSERT INTO `customer` (`id`, `first_name`, `last_name`, `birthdate`, `address_id`, `user_id`, `payment_info_id`, `create_date`, `customer_image`, `bio`) VALUES (3, 'Dorothy', 'Parker', '1893-08-22', 3, 3, 3, '1967-06-06', 'https://i2.wp.com/guyportman.com/wp-content/uploads/2013/10/dorothy-parker.jpg', NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `customer_order`
-- -----------------------------------------------------
START TRANSACTION;
USE `winenotdb`;
INSERT INTO `customer_order` (`id`, `customer_id`, `order_date`, `amount`, `size`, `wine_type_id`, `wine_color_id`, `processed`) VALUES (1, 1, '2020-01-01 11:11:11', 129.99, 6, NULL, NULL, 0);
INSERT INTO `customer_order` (`id`, `customer_id`, `order_date`, `amount`, `size`, `wine_type_id`, `wine_color_id`, `processed`) VALUES (2, 2, '2020-02-02 22:22:22', 129.99, 6, NULL, 1, 1);
INSERT INTO `customer_order` (`id`, `customer_id`, `order_date`, `amount`, `size`, `wine_type_id`, `wine_color_id`, `processed`) VALUES (3, 2, '2020-03-03 10:10:10', 220.99, 12, NULL, NULL, 0);

COMMIT;


-- -----------------------------------------------------
-- Data for table `order_wine`
-- -----------------------------------------------------
START TRANSACTION;
USE `winenotdb`;
INSERT INTO `order_wine` (`order_id`, `wine_id`, `quantity`) VALUES (1, 1, 1);
INSERT INTO `order_wine` (`order_id`, `wine_id`, `quantity`) VALUES (1, 2, 1);
INSERT INTO `order_wine` (`order_id`, `wine_id`, `quantity`) VALUES (1, 3, 1);
INSERT INTO `order_wine` (`order_id`, `wine_id`, `quantity`) VALUES (1, 4, 1);
INSERT INTO `order_wine` (`order_id`, `wine_id`, `quantity`) VALUES (1, 5, 1);
INSERT INTO `order_wine` (`order_id`, `wine_id`, `quantity`) VALUES (1, 6, 1);
INSERT INTO `order_wine` (`order_id`, `wine_id`, `quantity`) VALUES (2, 2, 1);
INSERT INTO `order_wine` (`order_id`, `wine_id`, `quantity`) VALUES (2, 11, 1);
INSERT INTO `order_wine` (`order_id`, `wine_id`, `quantity`) VALUES (2, 3, 1);
INSERT INTO `order_wine` (`order_id`, `wine_id`, `quantity`) VALUES (2, 9, 1);
INSERT INTO `order_wine` (`order_id`, `wine_id`, `quantity`) VALUES (2, 4, 1);
INSERT INTO `order_wine` (`order_id`, `wine_id`, `quantity`) VALUES (2, 5, 1);
INSERT INTO `order_wine` (`order_id`, `wine_id`, `quantity`) VALUES (3, 1, 1);
INSERT INTO `order_wine` (`order_id`, `wine_id`, `quantity`) VALUES (3, 2, 1);
INSERT INTO `order_wine` (`order_id`, `wine_id`, `quantity`) VALUES (3, 3, 1);
INSERT INTO `order_wine` (`order_id`, `wine_id`, `quantity`) VALUES (3, 4, 1);
INSERT INTO `order_wine` (`order_id`, `wine_id`, `quantity`) VALUES (3, 5, 1);
INSERT INTO `order_wine` (`order_id`, `wine_id`, `quantity`) VALUES (3, 6, 1);
INSERT INTO `order_wine` (`order_id`, `wine_id`, `quantity`) VALUES (3, 7, 1);
INSERT INTO `order_wine` (`order_id`, `wine_id`, `quantity`) VALUES (3, 8, 1);
INSERT INTO `order_wine` (`order_id`, `wine_id`, `quantity`) VALUES (3, 9, 1);
INSERT INTO `order_wine` (`order_id`, `wine_id`, `quantity`) VALUES (3, 10, 1);
INSERT INTO `order_wine` (`order_id`, `wine_id`, `quantity`) VALUES (3, 11, 1);
INSERT INTO `order_wine` (`order_id`, `wine_id`, `quantity`) VALUES (3, 12, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `payment`
-- -----------------------------------------------------
START TRANSACTION;
USE `winenotdb`;
INSERT INTO `payment` (`id`, `complete`, `order_id`, `payment_date`) VALUES (1, 1, 1, '2020-01-01 13:13:13');
INSERT INTO `payment` (`id`, `complete`, `order_id`, `payment_date`) VALUES (2, 1, 2, '2020-02-03 12:34:11');
INSERT INTO `payment` (`id`, `complete`, `order_id`, `payment_date`) VALUES (3, 1, 3, '2020-03-03 12:12:00');

COMMIT;


-- -----------------------------------------------------
-- Data for table `favorites`
-- -----------------------------------------------------
START TRANSACTION;
USE `winenotdb`;
INSERT INTO `favorites` (`customer_id`, `wine_id`) VALUES (1, 1);
INSERT INTO `favorites` (`customer_id`, `wine_id`) VALUES (1, 2);
INSERT INTO `favorites` (`customer_id`, `wine_id`) VALUES (1, 3);
INSERT INTO `favorites` (`customer_id`, `wine_id`) VALUES (2, 4);
INSERT INTO `favorites` (`customer_id`, `wine_id`) VALUES (2, 2);
INSERT INTO `favorites` (`customer_id`, `wine_id`) VALUES (3, 11);
INSERT INTO `favorites` (`customer_id`, `wine_id`) VALUES (3, 2);

COMMIT;


-- -----------------------------------------------------
-- Data for table `review`
-- -----------------------------------------------------
START TRANSACTION;
USE `winenotdb`;
INSERT INTO `review` (`image`, `rating`, `review`, `customer_id`, `wine_id`) VALUES (NULL, 5, 'Tasty and great.', 1, 1);
INSERT INTO `review` (`image`, `rating`, `review`, `customer_id`, `wine_id`) VALUES (NULL, 4, 'Mostly satisfied my alcoholic tendencies.', 2, 4);
INSERT INTO `review` (`image`, `rating`, `review`, `customer_id`, `wine_id`) VALUES (NULL, 3, 'Ok', 1, 5);
INSERT INTO `review` (`image`, `rating`, `review`, `customer_id`, `wine_id`) VALUES (NULL, 1, 'Awful. Very bad. Like watered down PBR.', 2, 7);
INSERT INTO `review` (`image`, `rating`, `review`, `customer_id`, `wine_id`) VALUES (NULL, 4, 'Decently good!', 1, 11);
INSERT INTO `review` (`image`, `rating`, `review`, `customer_id`, `wine_id`) VALUES (NULL, 5, 'Sometimes when I reflect back on all the wine I drink I feel shame. Then I look into the glass and think about the workers in the vineyards and all of their hopes and dreams. If I didn’t drink this...', 3, 3);

COMMIT;

