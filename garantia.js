window.addEventListener('load', function() {
    var injected = false;
    var observer = new MutationObserver(function() {
        if (injected) return;
        
        // Let's find the buy button by its text or styling
        var buttons = Array.from(document.querySelectorAll('a')).filter(el => 
            el.textContent.toLowerCase().includes('quero baixar') || 
            el.className.includes('bg-blue-600')
        );
        
        var targetSection = null;
        for (var i = 0; i < buttons.length; i++) {
            // Find the parent section of this button
            var sec = buttons[i].closest('section') || buttons[i].closest('.py-20');
            if (sec) {
                targetSection = sec;
            }
        }
        
        // If we found the section containing the pricing card
        if (targetSection) {
            injected = true;
            observer.disconnect();
            
            var garantiaHtml = `
            <style>
                #garantia-card-container {
                    width: 100%;
                    padding: 60px 20px 40px;
                    display: flex;
                    flex-direction: column;
                    align-items: center;
                    justify-content: center;
                    box-sizing: border-box;
                }
                .garantia-section-title {
                    font-size: 36px;
                    font-weight: 900;
                    color: #ffffff;
                    margin-bottom: 30px;
                    margin-top: 0;
                    text-align: center;
                    letter-spacing: -0.5px;
                    text-transform: uppercase;
                }
                .garantia-box {
                    max-width: 500px;
                    width: 100%;
                    border: 1px solid #22c55e;
                    border-radius: 16px;
                    background-color: #020617;
                    padding: 30px 20px;
                    display: flex;
                    flex-direction: column;
                    align-items: center;
                    text-align: center;
                    box-shadow: 0 0 15px rgba(34, 197, 94, 0.1);
                    box-sizing: border-box;
                }
                .garantia-img {
                    width: 120px;
                    margin-bottom: 20px;
                    object-fit: contain;
                }
                .garantia-title {
                    font-size: 24px;
                    font-weight: 800;
                    color: #ffffff;
                    margin-bottom: 15px;
                    margin-top: 0;
                    line-height: 1.2;
                }
                .garantia-text {
                    font-size: 15px;
                    color: #d1d5db;
                    margin-bottom: 25px;
                    line-height: 1.5;
                    max-width: 400px;
                }
                .garantia-footer-box {
                    width: 100%;
                    border: 1px solid rgba(34, 197, 94, 0.3);
                    border-radius: 12px;
                    padding: 15px;
                    background-color: rgba(34, 197, 94, 0.05);
                    box-sizing: border-box;
                }
                .garantia-footer-text {
                    font-size: 14px;
                    font-weight: 700;
                    color: #ffffff;
                    margin: 0;
                    line-height: 1.4;
                }
                .cta-bottom-button {
                    display: inline-block;
                    margin-top: 50px;
                    background-color: #2563eb;
                    color: #ffffff;
                    font-size: 20px;
                    font-weight: 900;
                    text-decoration: none;
                    padding: 20px 40px;
                    border-radius: 9999px;
                    box-shadow: 0 10px 25px -5px rgba(37, 99, 235, 0.4);
                    transition: transform 0.2s, background-color 0.2s;
                    text-align: center;
                    width: 100%;
                    max-width: 500px;
                    letter-spacing: 0.5px;
                }
                .cta-bottom-button:hover {
                    background-color: #3b82f6;
                    transform: scale(1.02);
                }
                .cta-bottom-button:active {
                    transform: scale(0.98);
                }
                @media (max-width: 600px) {
                    .garantia-section-title { font-size: 26px; }
                    .garantia-title { font-size: 20px; }
                    .garantia-text { font-size: 14px; }
                    .garantia-img { width: 100px; }
                }
            </style>
            <div id="garantia-card-container">
                <h3 class="garantia-section-title">Risco Absolutamente Zero!</h3>
                <div class="garantia-box">
                    <img src="/garantia.png" alt="Garantia de 7 dias" class="garantia-img" />
                    <h2 class="garantia-title">Garantia incondicional de 7 dias</h2>
                    <p class="garantia-text">
                        Você tem 7 dias para baixar e testar as músicas no seu pen drive, carro ou caminhão. Se não curtir a qualidade ou o repertório, devolvemos 100% do seu dinheiro. Sem perguntas e sem letras miúdas.
                    </p>
                    <div class="garantia-footer-box">
                        <p class="garantia-footer-text">
                            Seu investimento está 100% protegido. Você não tem nada a perder e milhares de músicas a ganhar.
                        </p>
                    </div>
                </div>
                
                <!-- CTA Button -->
                <a href="#ofertas" onclick="document.querySelector('a[href*=\'tilimcheckout\']').scrollIntoView({behavior: 'smooth'})" class="cta-bottom-button">
                    QUERO GARANTIR MEU ACESSO AGORA!
                </a>
            </div>`;
            
            targetSection.insertAdjacentHTML('afterend', garantiaHtml);
        }
    });
    
    observer.observe(document.body, { childList: true, subtree: true });
});
