package liberty.capstone.database.customerinventory;

import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

@SuppressWarnings({"MethodName", "PMD.MethodNamingConventions"})
public interface CustomerInventoryEntityDao extends JpaRepository<CustomerInventoryEntity, Long> {
    List<CustomerInventoryEntity> findAllByCustomer_Id(Long customerId);
}
