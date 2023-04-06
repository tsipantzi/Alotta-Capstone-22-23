package liberty.capstone.process.restaurantinventory;

import liberty.capstone.core.restaurantinventory.RestaurantInventory;
import liberty.capstone.core.restaurantinventory.RestaurantInventoryService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Slf4j
@RestController
@RequiredArgsConstructor
@RequestMapping("/restaurant/{id}/inventory")
public class RestaurantInventoryController {
    private final RestaurantInventoryService inventoryService;

    @GetMapping
    public List<RestaurantInventory> getRestaurantInventoryByName(@PathVariable final Long id) {
        final var inventory = inventoryService.getRestaurantInventoryById(id);
        log.info("Found inventory for restaurant {} : {}", inventory.get(0).getRestaurant().getName(), inventory);
        return inventory;
    }
}
