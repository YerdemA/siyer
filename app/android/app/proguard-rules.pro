# Flutter Gradle eklentisi bu dosyayı release küçültmesine kendiliğinden ekler.

# Play Asset Delivery kitaplığı WorkManager kullanır; WorkManager da Room
# veritabanını (WorkDatabase_Impl) yansımayla kurar. R8 bu sınıfı ya da
# kurucusunu silince uygulama açılışta çöküyordu (2026-11-22, Xiaomi, Android 11).
-keep class * extends androidx.room.RoomDatabase { <init>(); }
-keep class androidx.work.impl.WorkDatabase_Impl { *; }
