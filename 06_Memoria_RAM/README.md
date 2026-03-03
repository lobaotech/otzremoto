# 11 - Ajustes de Memória RAM

Esta pasta contém scripts para otimizar o uso da memória RAM e do arquivo de paginação (memória virtual) no Windows. Otimizar essas configurações pode melhorar o desempenho geral do sistema, especialmente em jogos e aplicações que consomem muita memória.

## Scripts Disponíveis:

- **01_ajustes_memoria_ram.bat**: Este script detecta a quantidade de RAM instalada no sistema e ajusta automaticamente o tamanho do arquivo de paginação (memória virtual) para valores recomendados (1.5x RAM para mínimo e 3x RAM para máximo). Ele também tenta liberar a lista de espera (Standby List) da RAM, o que pode ser útil para liberar memória para novos aplicativos. Para a função de liberar a lista de espera, é necessário ter o utilitário `EmptyStandbyList.exe` na mesma pasta do script.

## Como Usar:

1.  **Execute como Administrador**: Clique com o botão direito no script `.bat` e selecione "Executar como administrador".
2.  **Siga as Instruções**: O script exibirá informações sobre a RAM detectada e os ajustes que serão aplicados.
3.  **Utilitário `EmptyStandbyList.exe`**: Para a otimização da lista de espera, baixe o `EmptyStandbyList.exe` do site da Sysinternals (Microsoft) e coloque-o na mesma pasta deste script.
4.  **Reinicie o Sistema**: É altamente recomendável reiniciar o computador após aplicar esses ajustes para que todas as alterações tenham efeito completo.

## Observações Importantes:

-   **Arquivo de Paginação**: O arquivo de paginação é uma extensão da memória RAM no disco rígido. Ajustá-lo corretamente pode evitar travamentos e melhorar a estabilidade, mas tamanhos excessivos podem consumir espaço em disco desnecessariamente.
-   **Lista de Espera (Standby List)**: O Windows mantém dados em cache na RAM (Standby List) para acesso rápido. Em alguns casos, essa lista pode reter memória que poderia ser usada por outros aplicativos. O `EmptyStandbyList.exe` força a liberação dessa memória.
-   **Crie um Ponto de Restauração**: Sempre crie um ponto de restauração do sistema antes de fazer alterações significativas nas configurações de memória.
