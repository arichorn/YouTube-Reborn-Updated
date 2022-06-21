const callback = function() {
    chrome.storage.sync.get({
        // Global Options
        blockAdsOption: true,
        // Video Options
        enablePictureInPictureButtonOption: true,
        disableAutoPlayOption: false,
        disableCaptionsOption: false,
        disableHeatwaveOption: false,
        // NavBar Options
        hideVoiceSearchButtonOption: false,
        hideYouTubeLogoOption: false,
        hideCountrySymbolNextToLogoOption: false,
        // Overlay Options
        hideAutoPlaySwitchOption: false,
        hideCaptionsButtonOption: false,
        hideInfoCardButtonOption: false,
        hideMiniplayerButtonOption: false,
        hideTheaterModeButtonOption: false,
        hidePreviousButtonOption: false,
        hideNextButtonOption: false,
        // Other Options
        hideRelatedVideosSectionOption: false,
        hideCommentsSectionOption: false
    }, function(items) {
        // Global Options

        // Block Ads
        if (items.blockAdsOption == true) {
            $(".ytp-ad-skip-button.ytp-button").click();
            let player = $(".html5-video-player");
            player.removeClass("ad-created");
            player.removeClass("ad-showing");
            player.removeClass("ad-interrupting");
            $("ytd-promoted-sparkles-web-renderer").remove();
            $(".ytd-player-legacy-desktop-watch-ads-renderer").remove();
            $(".ytd-banner-promo-renderer").remove();
            $(".ytp-ad-persistent-progress-bar-container").remove();
            $(".ytp-paid-content-overlay").remove();
        }
        
        // Video Options

        // Enable Picture In Picture Button
        if (items.enablePictureInPictureButtonOption == true) {
            $(".ytp-pip-button").removeAttr("style");
        }
        // Disable AutoPlay
        if (items.disableAutoPlayOption == true) {
            if ($(".ytp-autonav-toggle-button").attr("aria-checked") === "true") {
                $(".ytp-button[data-tooltip-target-id='ytp-autonav-toggle-button']").click();
            }
        }
        // Disable Captions
        if (items.disableCaptionsOption == true) {
            $(".ytp-subtitles-button[aria-pressed='true']").click();
        }
        // Disable Heatwave
        if (items.disableHeatwaveOption == true) {
            $(".ytp-heat-map-container").remove();
        }

        // NavBar Options

        // Hide Voice Search Button
        if (items.hideVoiceSearchButtonOption == true) {
            $("#voice-search-button").remove();
        }
        // Disable YouTube Logo
        if (items.hideYouTubeLogoOption == true) {
            $("ytd-topbar-logo-renderer").remove();
        }
        // Hide Country Symbol Next To Logo
        if (items.hideCountrySymbolNextToLogoOption == true) {
            $("#country-code").remove();
        }

        // Overlay Options

        // Hide AutoPlay Switch
        if (items.hideAutoPlaySwitchOption == true) {
            $(".ytp-button[data-tooltip-target-id='ytp-autonav-toggle-button']").remove();
        }
        // Hide Captions Button
        if (items.hideCaptionsButtonOption == true) {
            $(".ytp-subtitles-button").remove();
        }
        // Hide InfoCard Button
        if (items.hideInfoCardButtonOption == true) {
            $(".ytp-cards-button-icon").remove();
        }
        // Hide Miniplayer Button
        if (items.hideMiniplayerButtonOption == true) {
            $(".ytp-miniplayer-button").remove();
        }
        // Hide Theather Mode Button
        if (items.hideTheaterModeButtonOption == true) {
            $(".ytp-size-button").remove();
        }
        // Hide Previous Button
        if (items.hidePreviousButtonOption == true) {
            $(".ytp-prev-button").remove();
        }
        // Hide Next Button
        if (items.hideNextButtonOption == true) {
            $(".ytp-next-button").remove();
        }

        // Other Options

        // Hide Related Videos
        if (items.hideRelatedVideosSectionOption) {
            $("#related").remove();
        }
        // Hide Comments
        if (items.hideCommentsSectionOption) {
            $(".ytd-comments[section-identifier='comment-item-section']").remove();
        }

        $("ytd-metadata-row-header-renderer.ytd-metadata-row-container-renderer > h4#content > yt-formatted-string.ytd-metadata-row-header-renderer > a[href='/premium']").remove();
    });
}

var qualityObserver = new MutationObserver(function() {
    chrome.storage.sync.get({
        // Global Options
        qualityOption: "auto"
    }, function(items) {
        // Global Options
        if (items.qualityOption != "auto") {
            $(".ytp-settings-button")[0].click();

            var menuButtons = $(".ytp-menuitem-label");

            for (var i = 0; i < menuButtons.length; i++) {
                if (menuButtons[i].innerHTML === 'Quality') {
                    menuButtons[i].click();
                }
            }

            if (items.qualityOption == "best") {
                $(".ytp-quality-menu .ytp-menuitem-label")[0].click();
                qualityObserver.disconnect();
            } else if (items.qualityOption == "2160p") {
                var qualityButtons = $(".ytp-quality-menu .ytp-menuitem-label");

                for (var i = 0; i < qualityButtons.length; i++) {
                    if (qualityButtons[i].innerHTML.includes('2160p')) {
                        qualityButtons[i].click();
                        qualityObserver.disconnect();
                        break;
                    } else if (qualityButtons[i].innerHTML.includes('1440p')) {
                        qualityButtons[i].click();
                        qualityObserver.disconnect();
                        break;
                    } else if (qualityButtons[i].innerHTML.includes('1080p')) {
                        qualityButtons[i].click();
                        qualityObserver.disconnect();
                        break;
                    } else if (qualityButtons[i].innerHTML.includes('720p')) {
                        qualityButtons[i].click();
                        qualityObserver.disconnect();
                        break;
                    } else if (qualityButtons[i].innerHTML.includes('480p')) {
                        qualityButtons[i].click();
                        qualityObserver.disconnect();
                        break;
                    } else if (qualityButtons[i].innerHTML.includes('360p')) {
                        qualityButtons[i].click();
                        qualityObserver.disconnect();
                        break;
                    } else if (qualityButtons[i].innerHTML.includes('240p')) {
                        qualityButtons[i].click();
                        qualityObserver.disconnect();
                        break;
                    } else if (qualityButtons[i].innerHTML.includes('144p')) {
                        qualityButtons[i].click();
                        qualityObserver.disconnect();
                        break;
                    }
                }
            } else if (items.qualityOption == "1440p") {
                var qualityButtons = $(".ytp-quality-menu .ytp-menuitem-label");

                for (var i = 0; i < qualityButtons.length; i++) {
                    if (qualityButtons[i].innerHTML.includes('1440p')) {
                        qualityButtons[i].click();
                        qualityObserver.disconnect();
                        break;
                    } else if (qualityButtons[i].innerHTML.includes('1080p')) {
                        qualityButtons[i].click();
                        qualityObserver.disconnect();
                        break;
                    } else if (qualityButtons[i].innerHTML.includes('720p')) {
                        qualityButtons[i].click();
                        qualityObserver.disconnect();
                        break;
                    } else if (qualityButtons[i].innerHTML.includes('480p')) {
                        qualityButtons[i].click();
                        qualityObserver.disconnect();
                        break;
                    } else if (qualityButtons[i].innerHTML.includes('360p')) {
                        qualityButtons[i].click();
                        qualityObserver.disconnect();
                        break;
                    } else if (qualityButtons[i].innerHTML.includes('240p')) {
                        qualityButtons[i].click();
                        qualityObserver.disconnect();
                        break;
                    } else if (qualityButtons[i].innerHTML.includes('144p')) {
                        qualityButtons[i].click();
                        qualityObserver.disconnect();
                        break;
                    }
                }
            } else if (items.qualityOption == "1080p") {
                var qualityButtons = $(".ytp-quality-menu .ytp-menuitem-label");

                for (var i = 0; i < qualityButtons.length; i++) {
                    if (qualityButtons[i].innerHTML.includes('1080p')) {
                        qualityButtons[i].click();
                        qualityObserver.disconnect();
                        break;
                    } else if (qualityButtons[i].innerHTML.includes('720p')) {
                        qualityButtons[i].click();
                        qualityObserver.disconnect();
                        break;
                    } else if (qualityButtons[i].innerHTML.includes('480p')) {
                        qualityButtons[i].click();
                        qualityObserver.disconnect();
                        break;
                    } else if (qualityButtons[i].innerHTML.includes('360p')) {
                        qualityButtons[i].click();
                        qualityObserver.disconnect();
                        break;
                    } else if (qualityButtons[i].innerHTML.includes('240p')) {
                        qualityButtons[i].click();
                        qualityObserver.disconnect();
                        break;
                    } else if (qualityButtons[i].innerHTML.includes('144p')) {
                        qualityButtons[i].click();
                        qualityObserver.disconnect();
                        break;
                    }
                }
            } else if (items.qualityOption == "720p") {
                var qualityButtons = $(".ytp-quality-menu .ytp-menuitem-label");

                for (var i = 0; i < qualityButtons.length; i++) {
                    if (qualityButtons[i].innerHTML.includes('720p')) {
                        qualityButtons[i].click();
                        qualityObserver.disconnect();
                        break;
                    } else if (qualityButtons[i].innerHTML.includes('480p')) {
                        qualityButtons[i].click();
                        qualityObserver.disconnect();
                        break;
                    } else if (qualityButtons[i].innerHTML.includes('360p')) {
                        qualityButtons[i].click();
                        qualityObserver.disconnect();
                        break;
                    } else if (qualityButtons[i].innerHTML.includes('240p')) {
                        qualityButtons[i].click();
                        qualityObserver.disconnect();
                        break;
                    } else if (qualityButtons[i].innerHTML.includes('144p')) {
                        qualityButtons[i].click();
                        qualityObserver.disconnect();
                        break;
                    }
                }
            } else if (items.qualityOption == "480p") {
                var qualityButtons = $(".ytp-quality-menu .ytp-menuitem-label");

                for (var i = 0; i < qualityButtons.length; i++) {
                    if (qualityButtons[i].innerHTML.includes('480p')) {
                        qualityButtons[i].click();
                        qualityObserver.disconnect();
                        break;
                    } else if (qualityButtons[i].innerHTML.includes('360p')) {
                        qualityButtons[i].click();
                        qualityObserver.disconnect();
                        break;
                    } else if (qualityButtons[i].innerHTML.includes('240p')) {
                        qualityButtons[i].click();
                        qualityObserver.disconnect();
                        break;
                    } else if (qualityButtons[i].innerHTML.includes('144p')) {
                        qualityButtons[i].click();
                        qualityObserver.disconnect();
                        break;
                    }
                }
            } else if (items.qualityOption == "360p") {
                var qualityButtons = $(".ytp-quality-menu .ytp-menuitem-label");

                for (var i = 0; i < qualityButtons.length; i++) {
                    if (qualityButtons[i].innerHTML.includes('360p')) {
                        qualityButtons[i].click();
                        qualityObserver.disconnect();
                        break;
                    } else if (qualityButtons[i].innerHTML.includes('240p')) {
                        qualityButtons[i].click();
                        qualityObserver.disconnect();
                        break;
                    } else if (qualityButtons[i].innerHTML.includes('144p')) {
                        qualityButtons[i].click();
                        qualityObserver.disconnect();
                        break;
                    }
                }
            } else if (items.qualityOption == "240p") {
                var qualityButtons = $(".ytp-quality-menu .ytp-menuitem-label");

                for (var i = 0; i < qualityButtons.length; i++) {
                    if (qualityButtons[i].innerHTML.includes('240p')) {
                        qualityButtons[i].click();
                        qualityObserver.disconnect();
                        break;
                    } else if (qualityButtons[i].innerHTML.includes('144p')) {
                        qualityButtons[i].click();
                        qualityObserver.disconnect();
                        break;
                    }
                }
            } else if (items.qualityOption == "144p") {
                var qualityButtons = $(".ytp-quality-menu .ytp-menuitem-label");

                for (var i = 0; i < qualityButtons.length; i++) {
                    if (qualityButtons[i].innerHTML.includes('144p')) {
                        qualityButtons[i].click();
                        qualityObserver.disconnect();
                        break;
                    }
                }
            }
        } else {
            qualityObserver.disconnect();
        }
    });
});

new MutationObserver(callback).observe(document.body, {childList: true, subtree: true });

function run() {
    qualityObserver.observe(document.body, {childList: true, subtree: true });
}

window.onload = run;
window.addEventListener('yt-navigate-start', run, true);