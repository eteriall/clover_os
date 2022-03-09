# CloverOS

### CloverOS - Сервис с программным обеспечением для программирования дронов.
## http://alpha.coex-cloud.ru

<img width="1680" alt="Снимок экрана 2022-02-16 в 20 02 55" src="https://user-images.githubusercontent.com/57683566/154317387-83aa605d-06ab-418b-98a7-dd4084815c7d.png">


Модуль CloverOS входит в проект COEX-Cloud - Облачный сервис для моделирования поведения и программирования квадрокоптеров в облачной среде.

* `http://<ip_address>:8080` – Clover's web tools.
* `http://<ip_address>:57575` – Terminal.
* `http://<ip_address>:7070` – Gazebo web.
* `http://<ip_address>:591` – Visual Studio code.


<img src="https://user-images.githubusercontent.com/57683566/154319227-1a41ed9e-b7d9-484f-82ed-3586fbb76b19.png" width="600px">

Одномоментно на ВМ запущено 3 сервиса systemd:
- CLOVER-CLOUD-APP - CloverOS. Порт 80.
- CLOVER-CLOUD - Docker-контейнер с ROS, Gazebo и внутренним code-server для редактирования кода полётных программ. Выходные порты - 7070, 57575, 8080, 591, 8000.
- CODE-SERVER - Внешний VS-Code для тестирования новых функций и изменения исходного кода всех сервисов. Доступ может получить любой тестировщик, но после релиза сервиса - доступ к нему будет ограничен. Также, с помощью этого сервиса можно получить доступ к консоли ВМ с рут-правами. Порт 5000.
