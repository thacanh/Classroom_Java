<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <script src="https://cdnjs.cloudflare.com/ajax/libs/pdf.js/3.11.174/pdf.min.js"></script>
  <style>
    @import url('https://fonts.googleapis.com/css2?family=Nunito:wght@100;300;400;500;600;700&display=swap');
    @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@100;300;400;500;600;700&display=swap');
    @import url('https://fonts.googleapis.com/css2?family=Inter:wght@100;300;400;500;600;700&display=swap');
    @import url('https://fonts.googleapis.com/css2?family=Farro:wght@100;300;400;500;600;700&display=swap');

    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
      }

      body {
        font-family: "Poppins", sans-serif;
        font-weight: 500;
        background: #fff;
        min-height: 100vh;
      }
    
      /* Settings Panel */
      .settings-panel {
        position: fixed;
        top: 0;
        right: 0;
        width: 300px;
        height: 100vh;
        background: white;
        padding-top: calc(50px + 1.5rem); /* Header height + padding */
        padding-left: 1.5rem;
        padding-right: 1.5rem;
        padding-bottom: 1.5rem;
        display: flex;
        flex-direction: column;
        border-left: 1px solid #e5e7eb;
      }

      .tab-container {
        width: 100%;
        display: flex;
        margin-left: -105px;
        justify-content: center;
        margin-bottom: 2rem;
        margin-top: 50px;
      }

      .tabs {
        display: flex;
      }

      .tab {
        font-family: "Poppins", sans-serif;
        font-weight: 400;
        font-size: 14px;
        padding: 1rem 5rem;
        background: #f3f4f6;
        border: none;
        cursor: pointer;
        border-radius: 7px;
      }

      .tab.active {
        background: #ede9fe;
        color: #7c3aed;
        border-top-right-radius: 7px;
        border-bottom-right-radius: 7px;
      }

      .upload-container {
        font-family: "Poppins", sans-serif;
        font-weight: 400;
        font-size: 15px;
        width: 75%;
        display: flex;
        flex-direction: column;
        align-items: center;
        transition: width 0.3s;
        position: relative; /* Thêm dòng này */
        padding-bottom: 60px; /* Thêm dòng này để tạo khoảng trống cho nút */
        margin-left: 30px
    }
      

    .file-upload {
      width: 100%;
      border: 2px dashed #667eea;
      border-radius: 12px;
      padding: 20px;
      text-align: center;
      margin-bottom: 20px;
      cursor: pointer;
      transition: all 0.3s ease;
    }

    .file-upload:hover {
      background: #f0f4ff;
    }

    .file-upload input[type="file"] {
      display: none;
    }
      
    .summarize-button{
      font-family: "Poppins", sans-serif;
      font-weight: 500;
      font-size: 14px;
      padding: 1rem 5rem;
      background: #7c3aed;
      border: none;
      cursor: pointer;
      border-radius: 7px;
      color: white;
      position: absolute; /* Thay đổi từ relative sang absolute */
      bottom: 0; /* Đặt nút ở dưới cùng của container */
      left: 50%; /* Căn giữa nút */
      transform: translateX(-50%); /* Căn giữa nút */
    }

    .summary-output{
      width: 90%;
      min-height: 200px;
      padding: 15px;
      margin: 20px 0;
      border: 2px solid #e5e7eb;
      border-radius: 12px;
      font-family: inherit;
      resize: vertical;
      display: none;
    }

      .upload-icon {
        color: #9ca3af;
        width: 2.5rem;
        height: 2.5rem;
      }

      .upload-text {
        color: #6b7280;
      }

      .settings-header {
        display: flex;
        align-items: center;
        gap: 0.5rem;
        padding: 0.75rem;
        background: #e5e7eb;
        border-radius: 0.5rem;
        margin-bottom: 1.5rem;
      }

      .settings-section {
        font-family: "Poppins", sans-serif;
        font-weight: 500;
        font-size: 14px;
        margin-bottom: 0.5rem;
        color: #374151;
        margin-bottom: 1.5rem;
      }

      .settings-label {
        font-family: "Poppins", sans-serif;
        font-weight: 500;
        font-size: 14px;
        margin-bottom: 0.5rem;
        color: #374151;
      }

      .settings-select {
        font-family: "Poppins", sans-serif;
        font-weight: 400;
        font-size: 13px;
        width: 100%;
        padding: 0.75rem;
        background: white;
        border: 1px solid #e5e7eb;
        border-radius: 0.5rem;
        display: flex;
        justify-content: space-between;
        align-items: center;
        cursor: pointer;
      }

      .text-input {
        width: 90%;
        display: flex;
        min-height: 200px;
        position: relative;
        align-items: center;
        padding-bottom: 60px;
        flex-direction: column;
        padding: 15px;
        transition: width 0.3s;
        border: 2px solid #e5e7eb;
        border-radius: 12px;
        font-family: inherit;
    }
    .text-input-container{
        width: 83%;
        display: flex;
        flex-direction: column;
        align-items: center;
        transition: width 0.3s;
        position: relative; /* Thêm dòng này */
        padding-bottom: 100px; /* Thêm dòng này để tạo khoảng trống cho nút */
        margin-left: 30px;
    }
    .response-container {
        margin-top: 20px; /* Khoảng cách phía trên */
    }

    .response-output {
        margin-top: 10px;
        padding: 10px;
        border: 1px solid #ccc;
        border-radius: 5px;
        background-color: #f9f9f9; /* Màu nền nhạt cho phần phản hồi */
    }
        
    /* Loading Spinner Styles */
    .spinner {
      width: 50px;
      height: 50px;
      margin: 20px auto;
      border: 5px solid #f3f3f3;
      border-top: 5px solid #667eea;
      border-radius: 50%;
      animation: spin 1s linear infinite;
    }

    .loading-text {
      color: #667eea;
      font-weight: 600;
      margin-top: 15px;
      animation: pulse 1.5s ease-in-out infinite;
    }
    .loading-text1{
      color: #667eea;
      font-weight: 600;
      margin-top: 15px;
      animation: pulse 1.5s ease-in-out infinite;
    }

    @keyframes spin {
      0% { transform: rotate(0deg); }
      100% { transform: rotate(360deg); }
    }

    @keyframes pulse {
      0%, 100% { opacity: 1; }
      50% { opacity: 0.5; }
    }
    .file-info {
      margin-top: 10px;
      color: #4b5563;
    }

    #error-message {
        color: #ef4444;
        margin-top: 10px;
        display: none;
    }

    #error-message1 {
      color: #ef4444;
      margin-top: 10px;
      display: none;
    }

    /* Thêm hiệu ứng xuất hiện mượt mà */
    #result {
        animation: fadeIn 0.5s ease-in;
    }

    @keyframes fadeIn {
        from {
            opacity: 0;
            transform: translateY(-10px);
        }
        to {
            opacity: 1;
            transform: translateY(0);
        }
    }
  </style>
</head>
<body>
      <!-- Main Content -->
        <div class="tab-container">
            <div class="tabs">
              <button class="tab active" id="document-tab">Tài liệu</button>
              <button class="tab" id="text-tab">Văn bản</button>
            </div>
        </div>
    
        <div class="upload-container" id="document-container">
          <div class="file-upload" id="upload-area">
            <label for = "file-input">
              <div> 
                Thả tài liệu vào đây hoặc nhấn để chọn file
            </div>
            </label>
              <input type="file" id="file-input" accept=".pdf,.doc,.docx" />
          </div>

          <div id="file-info" class="file-info"></div>
          <div id="error-message"></div>
          
          <textarea class="summary-output" id="summary-output" readonly></textarea>
          
          <div class="loading" id="loading" style="display:none">
              <div class="spinner"></div>
              <div class="loading-text">Đang xử lí ...</div>
          </div>
          <button class="summarize-button" id="summarize-btn" style="display: none;">Tóm tắt</button>

      </div>
      
    
        <div class="text-input-container" id="text-container" style="display: none;">
            <label for="text-input" id = "reminder">Nhập văn bản vào đây:</label>
            <textarea id="text-input" class="text-input" rows="5" placeholder="Nhập gì đó ..."></textarea>          
            <div id="error-message1"></div>

            <textarea class="summary-output" id="summary-output1" readonly></textarea>

            <div class="loading" id="loading1" style="display: none;">
                <div class="spinner"></div>
                <div class="loading-text1">Đang xử lí ...</div>
            </div>

            <button class="summarize-button" id ="summarize-text">Tóm tắt</button>
        </div>

      <!-- Settings Panel -->
      <aside class="settings-panel">
        <div class="settings-header">
            <span>Cài đặt</span>
        </div>
      
      <div class="settings-section">
          <p class="settings-section">Ngôn ngữ</p>
          <select id="summary-language" class="settings-select">
              <option value="vietnamese">Tiếng Việt</option>
              <option value="english">Tiếng Anh</option>             
              <option value="french">Tiếng Pháp</option>
              <option value="german">Tiếng Đức</option>
          </select>
      </div>
      
      <div class="settings-section">
          <p class="settings-label">Mức độ chi tiết</p>
          <select class="settings-select" id="model-select">
              <option value="low">Thấp</option>
              <option value="medium">Trung bình</option>
              <option value="high">Cao</option>
          </select>
      </div>
    <script>
            // JavaScript để chuyển đổi giữa các tab
        document.getElementById('text-tab').addEventListener('click', function() {
        document.getElementById('document-container').style.display = 'none';
        document.getElementById('text-container').style.display = 'block';

        // Cập nhật trạng thái tab
        this.classList.add('active');
        document.getElementById('document-tab').classList.remove('active');
        });

        document.getElementById('document-tab').addEventListener('click', function() {
        document.getElementById('document-container').style.display = 'block';
        document.getElementById('text-container').style.display = 'none';

        // Cập nhật trạng thái tab
        this.classList.add('active');
        document.getElementById('text-tab').classList.remove('active');
        });

        const GEMINI_API_KEY = 'api-key';

        const fileInput = document.getElementById('file-input');
        const uploadArea = document.getElementById('upload-area');
        const fileInfo = document.getElementById('file-info');
        const errorMessage = document.getElementById('error-message');
        const summarizeBtn = document.getElementById('summarize-btn');
        const loadingDiv = document.getElementById('loading');
        const summaryOutput = document.getElementById('summary-output');
        const summarizeTextBtn = document.getElementById('summarize-text');
        const summaryOutput1 = document.getElementById('summary-output1')
        const errorMessage1 = document.getElementById('error-message1');
        const loadingDiv1 = document.getElementById('loading1');

        // Initialize PDF.js worker
        pdfjsLib.GlobalWorkerOptions.workerSrc = 'https://cdnjs.cloudflare.com/ajax/libs/pdf.js/3.11.174/pdf.worker.min.js';

        //Xử lý sự kiện kéo và thả
        uploadArea.addEventListener('dragover', (e) => {
            e.preventDefault();
            uploadArea.style.borderColor = '#764ba2';
        });

        uploadArea.addEventListener('dragleave', () => {
            uploadArea.style.borderColor = '#667eea';
        });

        uploadArea.addEventListener('drop', (e) => {
            e.preventDefault();
            uploadArea.style.borderColor = '#667eea';
            const file = e.dataTransfer.files[0];
            handleFile(file);
        });

        // Xử lý sự kiện chọn file
        fileInput.addEventListener('change', (e) => {
            const file = e.target.files[0];
            handleFile(file);
        });

        //Hàm xử lý file
        async function handleFile(file) {
            if (!file) return;

            const validTypes = ['application/pdf', 'application/msword', 'application/vnd.openxmlformats-officedocument.wordprocessingml.document'];
            if (!validTypes.includes(file.type)) {
                showError('Please upload a PDF or Word document.');
                return;
            }

            fileInfo.textContent = file.name;
            errorMessage.style.display = 'none';
            summarizeBtn.style.display = 'block';

            try {
                if (file.type === 'application/pdf') {
                    fileContent = await extractPdfText(file);
                } else {
                    // For Word documents, you'll need to implement a server-side solution
                    // or use a different library as Word processing in browser is limited
                    showError('Word document processing is currently not supported in this demo.');
                    return;
                }
            } catch (error) {
                showError('Error processing file. Please try again.');
                console.error(error);
            }
        }

        //Hàm trích xuất văn bản từ PDF
        async function extractPdfText(file) {
            const arrayBuffer = await file.arrayBuffer();
            const pdf = await pdfjsLib.getDocument({ data: arrayBuffer }).promise;
            let text = '';

            for (let i = 1; i <= pdf.numPages; i++) {
                const page = await pdf.getPage(i);
                const content = await page.getTextContent();
                text += content.items.map(item => item.str).join(' ') + '\n';
            }

            return text;
        }

        //Hàm gọi API tóm tắt tài liệu
        async function summarizeDocument() {
            const summaryLanguage = document.getElementById('summary-language').value;
            const modelSelect = document.getElementById('model-select').value;
            console.log('Summary Language:', summaryLanguage);
            console.log('Model Select:', modelSelect);
            console.log('File Content :', fileContent);
            if (!fileContent) {
                showError('Please upload a document first.');
                return;
            }

            loadingDiv.style.display = 'block';
            summarizeBtn.style.display = 'none';
            summaryOutput.style.display = 'none';

            try {
                const response = await fetch('https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key=AIzaSyAKhfqEDyiqK2U5xlOX6DePwW01zpYgI-0', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({
                        contents: [{
                            parts: [{
                                text: 'As a professional document summarizer, using ' + modelSelect + ' for level of detail, follow these guidelines: ' +
                              '1. Begin with a brief overview of the document\'s main topic ' +
                              '2. Identify and list key points in bullet format ' +
                              '3. Highlight important conclusions or recommendations ' +
                              '4. Structure the summary in clear sections: Overview, Key Points, Details, Conclusions ' +
                              '5. Maintain technical accuracy while making complex information accessible ' +
                              '6. Keep the summary concise but comprehensive ' +
                              '7. Do not use markdown like ### or italic or bold, whenever is a title, just write in all uppercase ' +
                              '8. Do not use asterisks (**) for bold text or any other formatting symbols. ' +
                              'Please summarize the following document: ' + fileContent + ' in ' + summaryLanguage
                            }]
                        }],
                        generationConfig: {
                            temperature: 0.7,
                            maxOutputTokens: 1000
                        }
                    })
                });

                if (!response.ok) {
                    throw new Error('Failed to generate summary');
                }

                const data = await response.json();
                summaryOutput.value = data.candidates[0].content.parts[0].text;
                summaryOutput.style.display = 'block';
            } catch (error) {
                showError('Error generating summary. Please try again.');
                console.error(error);
            } finally {
                loadingDiv.style.display = 'none';
                summarizeBtn.style.display = 'block';
            }
        }

        // Hàm tóm tắt văn bản nhập vào
        async function summarizeTextInput() {
            const textContent = document.getElementById('text-input').value;
            const summaryLanguage = document.getElementById('summary-language').value;
            const modelSelect = document.getElementById('model-select').value;

            if (!textContent.trim()) {
                showError1('Please enter some text to summarize.');
                return;
            }

            loadingDiv1.style.display = 'block';
            summarizeTextBtn.style.display = 'none';
            summaryOutput1.style.display = 'none';

            try {
                const response = await fetch('https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key=AIzaSyAKhfqEDyiqK2U5xlOX6DePwW01zpYgI-0', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({
                        contents: [{
                            parts: [{
                                text: 'As a professional document summarizer, using ' + modelSelect + ' for level of detail, follow these guidelines: ' +
                              '1. Begin with a brief overview of the document\'s main topic ' +
                              '2. Identify and list key points in bullet format ' +
                              '3. Highlight important conclusions or recommendations ' +
                              '4. Structure the summary in clear sections: Overview, Key Points, Details, Conclusions ' +
                              '5. Maintain technical accuracy while making complex information accessible ' +
                              '6. Keep the summary concise but comprehensive ' +
                              '7. Do not use markdown like ### or italic or bold, whenever is a title, just write in all uppercase ' +
                              '8. Do not use asterisks (**) for bold text or any other formatting symbols. ' +
                              'Please summarize the following document: ' + fileContent + ' in ' + summaryLanguage
                            }]
                        }],
                        generationConfig: {
                            temperature: 0.7,
                            maxOutputTokens: 1000
                        }
                    })
                });

                if (!response.ok) {
                    throw new Error('Failed to generate summary');
                }

                const data = await response.json();
                summaryOutput1.value = data.candidates[0].content.parts[0].text;
                summaryOutput1.style.display = 'block';
            } catch (error) {
                showError1('Error generating summary. Please try again.');
                console.error(error);
            } finally {
                loadingDiv1.style.display = 'none';
                summarizeTextBtn.style.display = 'block';
            }
        }


        //Hàm hiển thị thông báo lỗi
        function showError(message) {
            errorMessage.textContent = message;
            errorMessage.style.display = 'block';
        }
        function showError1(message) {
            errorMessage1.textContent = message;
            errorMessage1.style.display = 'block';
        }

        //Gán sự kiện nút tóm tắt
        summarizeBtn.addEventListener('click', summarizeDocument);
        summarizeTextBtn.addEventListener('click', summarizeTextInput);
    </script>
</body>
</html>
