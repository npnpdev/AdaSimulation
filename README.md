# AdaSimulation

[English](#english-version) | [Polski](#wersja-polska)

---

## English Version

### Project Description

Concurrent producer-consumer simulation in Ada modeling a central buffer managing components and assembling products. Demonstrates Ada tasks, rendezvous, selective waits, and asynchronous transfers in a chosen domain (e.g., restaurant kitchen or production line).

### Key Features

* **Customized Theme**: domain-specific naming and behavior (e.g., restaurant orders).
* **Task Synchronization**: selective entry calls and asynchronous control shifts.
* **Concurrency Handling**:

  * Avoids deadlocks.
  * Dynamic buffer balancing with threshold-based waits.
* **Error and Edge Cases**:

  * Consumers reject assembly number 0.
  * Producer retry logic when buffer is full (up to 3 attempts).
* **Central Buffer Task**:

  * `Take`: accepts produced items if capacity allows and item is needed.
  * `Deliver`: provides complete assemblies or returns failure.
  * `Get_Storage_Level`, `Get_Most_Needed_Product`: buffer state queries.
* **Producer Tasks**:

  * Produce one component type with random delays.
  * Pause when buffer is >50% full or component not highest priority.
  * Retry on failure with back-off delays.
* **Consumer Tasks**:

  * Attempt up to 3 assemblies per cycle with timed rendezvous.
  * Randomly select assembly types, avoiding repeats.
  * Block or timed recoveries on failed deliveries.
* **Resource Management**: buffer capacity, additional stock thresholds.
* **Randomization**: Ada.Numerics.Discrete\_Random for production/consumption timing.
* **Logging**: ANSI escape sequences for colored console output.

### Architecture

```text
Global_Types  ← shared constants, types, names, assembly recipes
Buffer_Task   ← central buffer managing storage and rendezvous
Producer_Task ← produces specific components, implements retry and throttling
Consumer_Task ← assembles products with timed and blocking delivers
general main  ← initializes tasks, starts simulation
```

## Wersja polska

### Opis projektu

Symulacja producent–konsument w Adzie z centralnym buforem zarządzającym komponentami i zestawami. Demonstruje zadania, rendezvous, selektywne oczekiwanie i asynchroniczne przekazanie sterowania w wybranej tematyce (np. kuchnia restauracji, linia produkcyjna).

### Kluczowe funkcje

* **Tematyka**: spersonalizowane nazwy i zachowania (np. zamówienia restauracyjne).
* **Synchronizacja zadań**: selektywne wejścia i ATC (`select … then abort …`).
* **Obsługa współbieżności**:

  * Zapobieganie zakleszczeniom.
  * Wyrównywanie bufora przez pauzy producentów.
* **Błędy i przypadki brzegowe**:

  * Konsument odrzuca zestaw nr 0.
  * Logika ponawiania producenta przy pełnym buforze (3 próby).
* **Bufor (task)**:

  * `Take`: przyjmowanie produktów w razie dostępnej pojemności i zapotrzebowania.
  * `Deliver`: wydawanie kompletnych zestawów lub zwrot błędu.
  * `Get_Storage_Level`, `Get_Most_Needed_Product`: zapytania o stan bufora.
* **Producenci (tasks)**:

  * Produkcja jednego typu komponentu z losowymi opóźnieniami.
  * Pauzowanie przy buforze >50% lub niskim priorytecie.
  * Retry z opóźnieniami w razie niepowodzenia.
* **Konsumenci (tasks)**:

  * Do 3 prób pobrania zestawu na cykl z timeoutem i blokadą.
  * Losowy wybór zestawów, unikanie powtórzeń.
  * Zachowanie przy braku dostawy: timeout lub oczekiwanie.
* **Zarządzanie zasobami**: pojemność bufora, zapas minimalny.
* **Losowość**: Ada.Numerics.Discrete\_Random.
* **Logowanie**: kolorowy output ANSI.

### Architektura

```text
Global_Types  ← stałe, typy i przepisy zestawów
Buffer_Task   ← zarządzanie magazynem i rendezvous
Producer_Task ← produkcja komponentów, retry i pauzy
Consumer_Task ← pobieranie zestawów z timeoutami
główny moduł ← inicjalizacja zadań i uruchomienie symulacji
```

## Autor / Author

Igor Tomkowicz
📧 [npnpdev@gmail.com](mailto:npnpdev@gmail.com)
GitHub: [npnpdev](https://github.com/npnpdev)
LinkedIn: [igor-tomkowicz](https://www.linkedin.com/in/igor-tomkowicz-a5760b358/)

## License

MIT License – see [LICENSE](LICENSE) for details.
